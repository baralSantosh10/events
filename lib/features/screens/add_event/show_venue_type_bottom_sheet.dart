import 'package:event/core/controllers/dashscreen/home_screen_controller.dart';
import 'package:event/core/model/category_model.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueTypeBottomSheet extends StatelessWidget {
  // final Function(String venueType) onSelectVenueType;
  final Function(CategoryModel venueType) onSelectVenueType;
  final homeController = Get.find<HomeScreenController>();
  VenueTypeBottomSheet({
    super.key,
    required this.onSelectVenueType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Venue Type",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const ClampingScrollPhysics(),
          //   itemCount: VenueType.values.length,
          //   itemBuilder: (context, index) {
          //     final venue = VenueType.values[index];
          //     return ListTile(
          //       onTap: () {
          //         Navigator.of(context).pop();
          //         onSelectVenueType(venue.toString().split('.').last);
          //       },
          //       title: Text(
          //         venue
          //             .toString()
          //             .split('.')
          //             .last, // Access the enum name directly from 'venue'
          //         style: CustomTextStyles.f16W400(),
          //       ),
          //       dense: true,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       tileColor: AppColors.primary,
          //       selected: true,
          //       style: ListTileStyle.drawer,
          //     );
          //   },
          // ),
          if (homeController.categoryList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: homeController.categoryList.length,
              itemBuilder: (context, index) {
                var category = homeController.categoryList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    // onSelectVenueType(category.title ?? "");
                    onSelectVenueType(category);
                  },
                  title: Text(
                    category.title ?? "",
                    style: CustomTextStyles.f16W400(),
                  ),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: AppColors.primary,
                  selected: true,
                  style: ListTileStyle.drawer,
                );
              },
            ),
        ],
      ),
    );
  }
}
