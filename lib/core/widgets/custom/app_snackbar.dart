import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/messages.dart';

class GearSnackBar {
  static success({String? title, String? message}) {
    Get.snackbar(
      title ?? "Success",
      message ?? Messages.successMessage,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      backgroundColor: AppColors.green,
      colorText: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      barBlur: 16.0,
    );
  }

  static error({String? title, String? message}) {
    Get.snackbar(
      title ?? "Error!",
      message ?? Messages.error1,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      backgroundColor: Colors.red.withOpacity(0.7),
      colorText: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      barBlur: 16.0,
    );
  }

  static info({String? title, required String message}) {
    Get.snackbar(
      title ?? "Info!",
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      backgroundColor: AppColors.lightGrey,
      colorText: Colors.white,
    );
  }
}
