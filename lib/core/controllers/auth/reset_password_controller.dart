// import 'dart:developer';

import 'package:event/core/repo/auth_repo.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:event/features/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom/app_progress_dialog.dart';

class ResetPasswordController extends GetxController {
  RxnString userOtp = RxnString();
  RxnString userToken = RxnString();
  @override
  void onInit() {
    var args = Get.arguments;

    if (args != null) {
      userOtp.value = args['otp'];
      userToken.value = args['token'];
    }

    super.onInit();
  }

  final resetPwKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConController = TextEditingController();

  final ProgressDialog loading = ProgressDialog();

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

  Future<void> onReset() async {
    if (resetPwKey.currentState!.validate()) {
      loading.show();

      await AuthRepo.resetPassword(
          password: passwordConController.text,
          otp: userOtp.value.toString(),
          token: userToken.value.toString(),
          onSuccess: (message) {
            loading.hide();
            Get.offAllNamed(LoginScreen.routeName);
            GearSnackBar.success(title: "Reset password", message: message);
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Reset password", message: message);
          });
    }
  }
}
