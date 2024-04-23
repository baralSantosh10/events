import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/widgets/common/common_alert.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/empty_view.dart';
import 'package:event/core/widgets/common/error_view.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:event/features/screens/add_event/update_event_screen.dart';
import 'package:event/features/screens/my_events/controller/my_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MyEventsScreen extends StatelessWidget {
  static const String routeName = "/my-events";
  final c = Get.find<myEventController>();
  MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Events",
          style: CustomTextStyles.f16W600(),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        // header: ClassicHeader(),
        header: const WaterDropHeader(),

        controller: c.refreshController,
        onRefresh: () => c.onRefresh(),
        child: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(() {
                  if (c.pageState.value == PageState.LOADING) {
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  } else if (c.pageState.value == PageState.EMPTY) {
                    return EmptyView(
                      message: "No events available",
                      title: "Not available",
                      media: IconPath.searching,
                      mediaSize: Get.height / 4,
                    );
                  } else if (c.pageState.value == PageState.NORMAL) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var event = c.eventList[index];
                          return MyEventRowWidget(
                            event: event,
                            //  onEdit: () => c.onEditClick(product),
                            onEdit: () {
                              Get.toNamed(UpdateEventScreen.routeName,
                                  arguments: {"event": event});
                            },
                            onConfirmDelete: () {
                              c.deleteProduct(event.id!);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: c.eventList.length);
                  } else {
                    return ErrorView(
                      message: "No any  events available right now",
                      title: "No Data Available.",
                      media: IconPath.error,
                      // mediaSize: Get.height / 4,
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyEventRowWidget extends StatelessWidget {
  final EventModel event;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const MyEventRowWidget({
    super.key,
    required this.event,
    required this.onConfirmDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            12,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SkyNetworkImage(
                  imageUrl: "${Api.imageUrl}${event.thumbnail}",
                  width: 60,
                  height: 60,
                  boxFit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    event.eventTitle ?? "",
                    style:
                        CustomTextStyles.f16W500(color: AppColors.blackColor),
                  ),
                  // Text(
                  //   event.eventDate ?? "",
                  //   style:
                  //       CustomTextStyles.f14W400(color: AppColors.blackColor),
                  // ),
                  if (event.eventDate != null)
                    RichText(
                      text: TextSpan(
                          text: 'Date: ',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: event.eventDate != null
                                  ? '${event.eventDate}'
                                  : '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),

                  RichText(
                    text: TextSpan(
                        text: 'VIP Seat Price: ',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: event.vipSeatsPrice != null
                                ? 'Rs. ${event.vipSeatsPrice}'
                                : "N/A",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                  ),
                  if (event.eventTime != null)
                    RichText(
                      text: TextSpan(
                          text: 'Time: ',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: event.eventTime != null
                                  ? '${event.eventTime} '
                                  : '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                  if (event.eventTime != null)
                    RichText(
                      text: TextSpan(
                          text: 'Location: ',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: event.location != null
                                  ? '${event.location} '
                                  : '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkResponse(
                    onTap: onEdit,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 238, 238),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        IconPath.edit,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkResponse(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomAlertDialog(
                                title: "Do you really want to delete ?",
                                message: "You cannot undo this action",
                                onConfirm: onConfirmDelete,
                                confirmText: "Yes");
                          });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 238, 238),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          IconPath.delete,
                          width: 10,
                          height: 10,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
