import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:event/core/widgets/shimmer/category_shimmer.dart';
import 'package:event/features/screens/events/event_detail_screen.dart';
import 'package:event/features/screens/favourites/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  static const String routeName = "/fav-screen";
  final c = Get.find<FavouriteController>();
  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourites",
          style: CustomTextStyles.f16W600(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return CategoryShimmer.categoryGrid();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return const Center(
                    child: Text("Empty"),
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
                      itemCount: c.favEventsLists.length,
                      itemBuilder: (context, index) {
                        var product = c.favEventsLists[index];
                        return FavEventCard(
                          event: product,
                          onConfirmDelete: () {
                            c.removeFromWishList(product.id!);
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error View"),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class FavEventCard extends StatelessWidget {
  final c = Get.find<FavouriteController>();
  final Function() onConfirmDelete;

  final EventModel event;
  FavEventCard({
    super.key,
    required this.onConfirmDelete,
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
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SkyNetworkImage(
                        imageUrl: "${Api.imageUrl}${event.thumbnail}",
                        height: 75,
                        // width: 80,
                        boxFit: BoxFit.fitWidth,
                        // alignment: Alignment.center,
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: InkResponse(
                          onTap: onConfirmDelete,
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color: AppColors.primary,
                          ),
                        ))
                  ],
                )),
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
