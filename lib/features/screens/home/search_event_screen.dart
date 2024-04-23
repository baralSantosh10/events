import 'package:event/core/controllers/dashscreen/home_screen_controller.dart';
import 'package:event/core/controllers/dashscreen/search_event/search_event_controller.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/empty_view.dart';
import 'package:event/core/widgets/common/error_view.dart';
import 'package:event/core/widgets/common/text_form_field.dart';
import 'package:event/features/screens/events/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/apis.dart';
import '../../../core/widgets/common/network_imge.dart';

class SearchEventScreen extends StatelessWidget {
  static const String routeName = "/search-event-screen";
  final c = Get.find<SearchEventController>();
  SearchEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryTextField(
          autofocus: true,
          hint: "Search Event",
          controller: c.searchController,
          onValueChange: (value) {
            c.onTextChange(value);
          },
          onSubmitted: (_) {
            c.searchEvents();
          },
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return EmptyView(
                    message: "Search events based on your interests.",
                    title: "Search Events",
                    media: IconPath.searching,
                    mediaSize: Get.height / 4,
                  );
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Looks like Empty",
                    title: "There is no events available.",
                    media: IconPath.empty,
                    mediaSize: Get.height / 4,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // number of items in each row
                              mainAxisSpacing: 20, // spacing between rows
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.8 // spacing between columns
                              ),
                      itemCount: c.searchList.length,
                      itemBuilder: (context, index) {
                        var product = c.searchList[index];
                        return SearchEventCard(
                          event: product,
                        );
                      },
                    ),
                  );
                } else {
                  return ErrorView(
                    message: "No Data Available.",
                    title: "No Data available at the moment",
                    media: IconPath.error,
                    mediaSize: Get.height / 4,
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

class SearchEventCard extends StatelessWidget {
  final c = Get.find<HomeScreenController>();
  // final String? icon;
  // final String? title;
  // final VoidCallback? onTap;
  // final String? location;
  // final String? price;
  final EventModel event;
  SearchEventCard({
    super.key,
    // required this.icon,
    // required this.title,
    // this.onTap,
    // this.location,
    // required this.price,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(EventDetailScreen.routeName, arguments: {"event": event});
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
            //   "$icon",
            //   height: 35,
            //   width: 35,
            //   alignment: Alignment.center,
            // ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child:
                    //  SvgPicture.asset(
                    //   "$icon",
                    //   height: 80,
                    //   width: 80,
                    //   alignment: Alignment.center,
                    // ),
                    SkyNetworkImage(
                  imageUrl: "${Api.imageUrl}${event.thumbnail}",
                  height: 80,
                  // width: 80,
                  boxFit: BoxFit.fitWidth,
                  // alignment: Alignment.center,
                ),
              ),
            ),

            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventTitle ?? "",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    // Text(
                    //   event.organizerId ?? "",
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         fontSize: 14,
                    //         color: AppColors.primary,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    // ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      event.eventDate ?? "",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event.eventTime ?? "",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        if (event.organizerId !=
                            c.coreController.currentUser.value?.id)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Book Now",
                              style: CustomTextStyles.f14W300(
                                  color: AppColors.whiteColor),
                            ),
                          ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
