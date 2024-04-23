import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/helpers/validators.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/text_form_field.dart';
import 'package:event/core/widgets/custom/app_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/dashscreen/profile/update_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const String routeName = "/update-profile";
  final c = Get.find<UpdateProfileController>();
  UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.blackColor, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Update Profile",
          style: CustomTextStyles.f16W600(
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: c.updateProfileKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Name",
                  style: CustomTextStyles.f20W400(color: AppColors.blackColor),
                ),
                PrimaryTextField(
                  onValueChange: (String value) {},
                  hint: "Fullname",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  validator: Validators.checknameEmpty,
                  controller: c.nameController,
                  // prefixIcon: const Icon(
                  //   Icons.person,
                  //   color: AppColors.,
                  // ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Email",
                  style: CustomTextStyles.f20W400(color: AppColors.blackColor),
                ),
                PrimaryTextField(
                  hint: "Email address",
                  controller: c.emailController,
                  onValueChange: (String value) {},
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  validator: Validators.checkEmailField,
                  // prefixIcon: const Icon(
                  //   Icons.email,
                  //   color: AppColors.redColor,
                  // ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Phone",
                  style: CustomTextStyles.f20W400(color: AppColors.blackColor),
                ),
                PrimaryTextField(
                  hint: "Phone",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: Validators.checkPhoneField,
                  controller: c.phoneController,
                  // prefixIcon: const Icon(
                  //   Icons.phone,
                  //   color: AppColors.redColor,
                  // ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Address",
                  style: CustomTextStyles.f20W400(color: AppColors.blackColor),
                ),
                PrimaryTextField(
                  hint: "Address",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkFieldEmpty,
                  onValueChange: (String value) {},
                  controller: c.addressController,
                  // prefixIcon: const Icon(
                  //   Icons.phone,
                  //   color: AppColors.redColor,
                  // ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => SkyRadioButton(
                        value: "Male",
                        groupVlaue: c.gender.value,
                        onTap: c.changeGender,
                        title: "Male",
                      ),
                    ),
                    Obx(
                      () => SkyRadioButton(
                        value: "Female",
                        groupVlaue: c.gender.value,
                        onTap: c.changeGender,
                        title: "Female",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                PrimaryOutlineButton(
                  // width: 100,
                  onPressed: c.onSubmit,
                  title: "Update",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
