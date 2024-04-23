import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:event/features/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../repo/auth_repo.dart';
import '../../widgets/custom/app_progress_dialog.dart';
import '../core_controller.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString gender = RxString("Male");
  void changeGender(String? data) {
    gender.value = data ?? "Male";
  }

  final CoreController coreController = Get.find();
  ProgressDialog loading = ProgressDialog();

  RxBool showPass = RxBool(false);
  RxBool showConPass = RxBool(false);
  final FocusNode passNode = FocusNode();
  final FocusNode conPassNode = FocusNode();
  void onEyeClick() {
    showPass.value = !showPass.value;
  }

  void onConEyeClick() {
    showConPass.value = !showConPass.value;
  }

  Future<void> onSubmit() async {
    if (signupKey.currentState!.validate()) {
      loading.show();
      var user = User(
        name: fullNameController.text,
        address: addressController.text,
        phonenumber: phoneController.text,
        email: emailController.text,
        gender: gender.value == "Male" ? "1" : "0",
      );
      await AuthRepo.signIn(
          user: user,
          password: passwordController.text,
          onSuccess: (user) {
            loading.hide();
            coreController.loadCurrentUser();
            Get.offAllNamed(LoginScreen.routeName);
            GearSnackBar.success(
                title: "Register Success",
                message: "Account created successfully");
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Register Failed", message: message);
          });
    }
  }
}
