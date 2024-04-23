import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/repo/auth_repo.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:event/features/screens/profile/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final coreController = Get.find<CoreController>();

  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final ProgressDialog loading = ProgressDialog();
  final resetPwKey = GlobalKey<FormState>();

  final FocusNode passNode = FocusNode();
  final FocusNode conPassNode = FocusNode();

  RxBool showPass = RxBool(false);
  RxBool showConPass = RxBool(false);

  void onEyeClick() {
    showPass.value = !showPass.value;
  }

  void onConEyeClick() {
    showConPass.value = !showConPass.value;
  }

  void openBottomSheetChangePW() async {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: Get.context!,
      showDragHandle: true,
      builder: (context) {
        return ChangePassword();
      },
    );
  }

  Future<void> onSubmit() async {
    if (resetPwKey.currentState!.validate()) {
      loading.show();
      await AuthRepo.changePassword(
          oldPassword: passwordController.text,
          newPassword: passwordConfirmController.text,
          onSuccess: (user) {
            coreController.loadCurrentUser();

            loading.hide();
            Get.back();
            GearSnackBar.success(
                title: "Password Change",
                message: "Your password has been successfully changed.");
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Password Change", message: message);
          });
    }
  }

  Future<void> becomeBoss() async {
    loading.show();
    await EventRepo.becomeOrganizer(
        userId: int.parse(coreController.currentUser.value!.id.toString()),
        onSuccess: (user) {
          coreController.loadCurrentUser();

          loading.hide();
          // Get.back();
          Get.find<CoreController>().logOut();
          // Get.offAllNamed(DashPageManager.routeName);
          GearSnackBar.success(
              title: "Organizer", message: "You are promoted to organizer.");
        },
        onError: (message) {
          loading.hide();
          GearSnackBar.error(title: "Organizer", message: message);
        });
  }
}
