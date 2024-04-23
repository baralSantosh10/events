import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import 'custom_text_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;
  final Color confirmColor;
  final String confirmText;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.onCancel,
    required this.onConfirm,
    this.confirmColor = Colors.green,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.lightGrey,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: title == null
          ? null
          : Text(
              "$title",
              style: CustomTextStyles.f16W500(),
            ),
      content: message == null
          ? null
          : Text(
              "$message",
              textAlign: TextAlign.justify,
              style: CustomTextStyles.f16W400(color: AppColors.blackColor),
            ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: Text(
            "Cancel",
            style: CustomTextStyles.f16W600(
              color: AppColors.blackColor,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            confirmText,
            style: CustomTextStyles.f16W600(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
