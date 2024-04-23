import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/repo/auth_repo.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/screens/dashscreen/dashboard_panel.dart';
import '../../widgets/custom/app_snackbar.dart';

class LoginController extends GetxController {
  final CoreController coreController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ProgressDialog loading = ProgressDialog();
  RxBool showPass = RxBool(false);
  final FocusNode passNode = FocusNode();
  void onEyeClick() {
    showPass.value = !showPass.value;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show();
      await AuthRepo.login(
          email: emailController.text,
          password: passwordController.text,
          onSuccess: (user) {
            coreController.loadCurrentUser();

            loading.hide();
            Get.offAllNamed(DashPageManager.routeName);
            GearSnackBar.success(
                title: "Login Success", message: "User logged in successfully");
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Login Failed", message: message);
          });
    }
  }
}
