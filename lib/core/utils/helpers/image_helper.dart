import 'package:event/core/controllers/core_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final picker = ImagePicker();
  static final CoreController coreController = Get.find();

  static Future<void> pickImage({
    required ImageSource imageSource,
    required Function(XFile pickedImage) onPickImage,
    Function(String message)? onError,
    VoidCallback? onCancel,
  }) async {
    var hasAccess = await coreController.checkCameraPermission();

    if (!hasAccess) {
      if (onError != null) {
        onError("Access Denied");
        return;
      }
    }
    XFile? pickImage = await picker.pickImage(
      source: imageSource,
      imageQuality: 100,
    );
    if (pickImage != null) {
      onPickImage(pickImage);
    } else {
      if (onCancel != null) {
        onCancel();
      }
    }
  }
}
