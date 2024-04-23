import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/model/user_model.dart';
import 'package:event/core/repo/auth_repo.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();

  final coreController = Get.find<CoreController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxString gender = RxString("Male");

  @override
  void onInit() {
    // TODO: implement onInit
    nameController.text = coreController.currentUser.value?.name ?? "";
    phoneController.text = coreController.currentUser.value?.phonenumber ?? "";
    gender.value =
        coreController.currentUser.value?.gender == "1" ? "Male" : "Female";
    addressController.text = coreController.currentUser.value?.address ?? "";

    emailController.text = coreController.currentUser.value?.email ?? "";

    super.onInit();
  }

  void changeGender(String? data) {
    gender.value = data ?? "Female";
  }

  RxBool showPass = RxBool(false);
  RxBool showConPass = RxBool(false);

  final FocusNode passNode = FocusNode();
  final FocusNode conPassNode = FocusNode();

  ProgressDialog loading = ProgressDialog();

  Future<void> onSubmit() async {
    if (updateProfileKey.currentState!.validate()) {
      loading.show();
      var user = User(
        name: nameController.text,
        address: addressController.text,
        phonenumber: phoneController.text,
        email: emailController.text,
        gender: gender.value == "Male" ? "1" : "0",
      );
      await AuthRepo.updateProfile(
          user: user,
          // onSuccess: (user) {
          //   loading.hide();
          //   // StorageHelper.saveUser(user);
          //   coreController.loadCurrentUser();
          //   // Get.offAllNamed(ProfileScreen.routeName);
          //   // Get.offNamed(ProfileScreen.routeName);
          //   // Get.offNamed(HomeScreen.routeName);
          //   Get.back();

          //   // Get.offNamed(ProfileScreen.routeName);
          //   GearSnackBar.success(
          //       title: "Update Success",
          //       message: "Account Updated successfully");
          // },
          onSuccess: (msg) {
            loading.hide();
            // StorageHelper.saveUser(user);
            coreController.loadCurrentUser();

            Get.back();

            GearSnackBar.success(
                title: "Update Success",
                message: "Account Updated successfully");
          },
          onError: (message) {
            loading.hide();
            GearSnackBar.error(title: "Update Failed", message: message);
          });
    }
  }
}
