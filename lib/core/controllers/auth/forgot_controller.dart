import 'package:event/core/repo/auth_repo.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/screens/auth/otp_verify_screen.dart';
import '../../widgets/custom/app_progress_dialog.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> sendMailKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  ProgressDialog loading = ProgressDialog();

  Future<void> onSubmit() async {
    if (sendMailKey.currentState!.validate()) {
      loading.show();
      await AuthRepo.forgotPassword(
          email: emailController.text,
          onSuccess: (token) {
            loading.hide();
            Get.offAllNamed(OTPVerifyScreen.routeName, arguments: {
              "token": token,
            });
            GearSnackBar.success(title: "OTP", message: "Verify your OTP");
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Forgot password", message: message);
          });
    }
  }
}
