import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XosialDatePicker {
  static DateTime _pickedDate = DateTime.now();

  static void pickDate(
      {required DateTime initialDate,
      DateTime? maxDate,
      DateTime? minDate,
      required Function(DateTime) onDone}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: Get.context!,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.whiteColor,
        ),
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.back();
                      onDone(_pickedDate);
                    },
                    child: Text(
                      "Done",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ))
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                maximumDate: maxDate,
                minimumDate: minDate,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDate) {
                  _pickedDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
