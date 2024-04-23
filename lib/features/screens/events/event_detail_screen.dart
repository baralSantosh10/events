import 'package:event/core/controllers/dashscreen/event/event_detail_controller.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailScreen extends StatelessWidget {
  static const String routeName = "/event-detail-screen";
  // final c = Get.put(EventsController());
  final c = Get.find<EventDetailController>();
  EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Detail"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         c.getEventDetail();
        //       },
        //       icon: Icon(
        //         Icons.add,
        //       ))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ),
              Stack(
                children: [
                  SkyNetworkImage(
                    // imageUrl: "",
                    imageUrl: "${Api.imageUrl}${c.event.value?.thumbnail}",
                    // height: 80,
                    width: Get.width,
                    height: 350,
                    boxFit: BoxFit.cover,
                    // alignment: Alignment.center,
                  ),
                  Obx(() => Positioned(
                        right: 5,
                        top: 10,
                        child: InkResponse(
                            onTap: c.toggleFav,
                            child: c.isLoadingFav.value
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : c.isFav.value
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
                                      )),
                      ))
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              if (c.event.value?.eventDate != null)
                Text(
                  "Event Date: ${c.event.value?.eventDate}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              const SizedBox(
                height: 4,
              ),
              if (c.event.value?.eventTime != null)
                Text(
                  "Event Time: ${c.event.value?.eventTime}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              const SizedBox(
                height: 8,
              ),
              if (c.event.value?.location != null)
                Text(
                  "Location: ${c.event.value?.location}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              const SizedBox(
                height: 8,
              ),
              if (c.event.value?.eventTitle != null)
                RichText(
                  text: TextSpan(
                      text: 'Event Name: ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${c.event.value?.eventTitle}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ),

              const SizedBox(
                height: 8,
              ),

              if (c.event.value?.totalSeats != null)
                RichText(
                  text: TextSpan(
                      text: 'Total Seats: ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${c.event.value?.totalSeats}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
              const SizedBox(
                height: 8,
              ),

              if (c.event.value?.totalVipSeats != null)
                RichText(
                  text: TextSpan(
                      text: 'Total VIP seats: ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: c.event.value?.vipSeatsPrice != null
                              ? '${c.event.value?.totalVipSeats} /Rs. ${c.event.value?.vipSeatsPrice}'
                              : '${c.event.value?.totalVipSeats} | N/A}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
              const SizedBox(
                height: 8,
              ),
              if (c.event.value?.totalPublicSeats != null)
                RichText(
                  text: TextSpan(
                      text: 'Total public seats: ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: c.event.value?.publicSeatsPrice != null
                              ? '${c.event.value?.totalPublicSeats} /Rs. ${c.event.value?.publicSeatsPrice}'
                              : '${c.event.value?.totalPublicSeats} | N/A}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
              const SizedBox(
                height: 20,
              ),
              if (c.event.value?.description != null)
                Text(
                  " ${c.event.value?.description}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          c.event.value?.organizerId != c.coreController.currentUser.value?.id
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryElevatedButton(
                    onPressed: () {
                      c.openBookingBootomSheet();
                    },
                    title: "Book Now",
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
