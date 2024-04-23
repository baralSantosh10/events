
import 'package:event/core/controllers/dashscreen/event/event_add_controller.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueLocationBottomSheet extends StatelessWidget {
  final Function(String venueType) onSelectVenue;
  final eventaddController = Get.find<EventAddController>();
  VenueLocationBottomSheet({
    super.key,
    required this.onSelectVenue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Venue location",
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
          if (eventaddController.venueList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: eventaddController.venueList.length,
              itemBuilder: (context, index) {
                var venue = eventaddController.venueList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    onSelectVenue(venue.title ?? "");
                  },
                  title: Text(
                    venue.title ?? "",
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
