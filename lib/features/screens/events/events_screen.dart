import 'package:event/core/controllers/dashscreen/event/event_controller.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:event/features/screens/events/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsScreen extends StatelessWidget {
  final c = Get.find<EventsController>();
  EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Available Events"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                    return Center(
                      child: Text("Empty"),
                    );
                  } else if (c.pageState.value == PageState.NORMAL) {
                    return ListView.separated(
                        itemCount: c.eventList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          var event = c.eventList[index];
                          return EventTileCard(
                            eventModel: event,
                          );
                        });
                  } else {
                    return Center(
                      child: Text("Error View"),
                    );
                  }
                })
              ],
            ),
          ),
        ));
  }
}

class EventTileCard extends StatelessWidget {
  final c = Get.find<EventsController>();
  final EventModel eventModel;

  EventTileCard({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(EventDetailScreen.routeName,
            arguments: {"event": eventModel});
      },
      child: Container(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 6),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 204, 203, 203),
              blurRadius: 2.0,
              spreadRadius: 1,
              offset: Offset(
                0,
                3,
              ),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SvgPicture.network(
            //   // APIPathHelper.imageUrl + icon.toString(),
            //   // IconPath.apple,
            //   "",
            //   height: 35,
            //   width: 35,
            //   alignment: Alignment.center,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(
                //   IconPath.apple,
                //   height: 80,
                //   width: 80,
                //   alignment: Alignment.center,
                // ),
                SkyNetworkImage(
                  // imageUrl: "",
                  imageUrl: "${Api.imageUrl}${eventModel.thumbnail}",
                  height: 80,
                  // width: 80,
                  boxFit: BoxFit.cover,
                  // alignment: Alignment.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (eventModel.eventDate != null)
                      Text(
                        "Event Date: ${eventModel.eventDate}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (eventModel.eventTime != null)
                      Text(
                        "Event Time: ${eventModel.eventTime}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (eventModel.location != null)
                      Text(
                        "Location: ${eventModel.location}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            // if (eventModel.eventTitle != null)
            //   Text(
            //     "Event Name: ${eventModel.eventTitle}",
            //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
            //           fontSize: 14,
            //           color: AppColors.blackColor,
            //           fontWeight: FontWeight.w600,
            //         ),
            //   ),
            if (eventModel.eventTitle != null)
              RichText(
                text: TextSpan(
                    text: 'Event Name: ',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${eventModel.eventTitle}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),

            const SizedBox(
              height: 5,
            ),

            if (eventModel.totalSeats != null)
              RichText(
                text: TextSpan(
                    text: 'Total Seats: ',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${eventModel.totalSeats}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),

            if (eventModel.totalVipSeats != null)
              RichText(
                text: TextSpan(
                    text: 'Total VIP seats: ',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: eventModel.vipSeatsPrice != null
                            ? '${eventModel.totalVipSeats} /Rs. ${eventModel.vipSeatsPrice}'
                            : '${eventModel.totalVipSeats} | N/A}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
            if (eventModel.totalPublicSeats != null)
              RichText(
                text: TextSpan(
                    text: 'Total public seats: ',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: eventModel.publicSeatsPrice != null
                            ? '${eventModel.totalPublicSeats} /Rs. ${eventModel.publicSeatsPrice}'
                            : '${eventModel.totalPublicSeats} | N/A}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventModel.description ?? "",
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                const SizedBox(
                  width: 4,
                ),
                // if (eventModel.organizerId !=
                //     c.coreController.currentUser.value?.id)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Get Details to Book",
                    style:
                        CustomTextStyles.f14W300(color: AppColors.whiteColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
