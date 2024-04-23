import 'package:event/core/controllers/dashscreen/my_booked_events/my_booked_events_controller.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/empty_view.dart';
import 'package:event/core/widgets/common/error_view.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookedEventsScreen extends StatelessWidget {
  static const String routeName = "/my-booked-events";
  final c = Get.find<MyBookedEventController>();
  MyBookedEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Booked Events",
          style: CustomTextStyles.f16W600(),
        ),
      ),
      body: SingleChildScrollView(
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
                    message: "No booked events available",
                    title: "Not available",
                    media: IconPath.searching,
                    mediaSize: Get.height / 4,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var event = c.bookedEventList[index];
                        return MyBookedEventRowWidget(
                          event: event,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: c.bookedEventList.length);
                } else {
                  return ErrorView(
                    message: "No any booked events right now",
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
    );
  }
}

class MyBookedEventRowWidget extends StatelessWidget {
  final EventModel event;
  const MyBookedEventRowWidget({
    super.key,
    required this.event,
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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SkyNetworkImage(
                  imageUrl: "${Api.imageUrl}${event.thumbnail}",

                  // imageUrl: "https://picsum.photos/200/300",
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
                                  ? '${event.eventDate} /VIP Rs. ${event.vipSeatsPrice}'
                                  : '${event.eventDate} | N/A}',
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
            ],
          ),
        ],
      ),
    );
  }
}
