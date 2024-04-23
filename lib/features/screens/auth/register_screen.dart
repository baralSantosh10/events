import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/image_path.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth/register_controller.dart';
import '../../../core/utils/helpers/validators.dart';
import '../../../core/widgets/common/text_form_field.dart';
import '../../../core/widgets/custom/app_radio_button.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register-screen";
  final c = Get.find<RegisterController>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: c.signupKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                ImagePath.logo,
                height: 150,
                fit: BoxFit.fitWidth,
                width: Get.width,
                // width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Register Here",
                        style:
                            CustomTextStyles.f20W500(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Name",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    PrimaryTextField(
                      hint: "Name",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      validator: Validators.checknameEmpty,
                      controller: c.fullNameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Email",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    PrimaryTextField(
                      hint: "Email",
                      controller: c.emailController,
                      onValueChange: (String value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      validator: Validators.checkEmailField,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Phone Number",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    PrimaryTextField(
                      hint: "Phone Number",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      validator: Validators.checkPhoneField,
                      controller: c.phoneController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Address",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    PrimaryTextField(
                      hint: "Address",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      validator: Validators.checkFieldEmpty,
                      onValueChange: (String value) {},
                      controller: c.addressController,
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
                      height: 16,
                    ),
                    Text(
                      "Password",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(
                      () => PrimaryTextField(
                        focusNode: c.passNode,
                        hint: "Password",
                        obscureText: !c.showPass.value,
                        controller: c.passwordController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.checkPasswordField,
                        eyeClick: c.onEyeClick,
                        onSubmitted: (_) {
                          // c.conPassNode.requestFocus();
                        },
                        onValueChange: (String value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Confirm Password",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(() => PrimaryTextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z0-9!@#\$%&'*,\-_+.]"))
                          ],
                          hint: "Confirm Password",
                          focusNode: c.conPassNode,
                          onSubmitted: (_) => c.onSubmit(),
                          obscureText: !c.showConPass.value,
                          eyeClick: c.onConEyeClick,
                          controller: c.confirmPasswordController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            var checkPassword =
                                Validators.checkPasswordField(value);
                            if (checkPassword != null) {
                              return checkPassword;
                            }

                            if (c.passwordController.text != value!) {
                              return "Password does not match";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryElevatedButton(
                      // onPressed: () {
                      //   Get.toNamed(LoginScreen.routeName);
                      // },
                      onPressed: c.onSubmit,
                      title: "Register",
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: CustomTextStyles.f15W600(
                              color: AppColors.primary),
                        ),
                        TextButton(
                            onPressed: () {
                              // Get.offNamed(LoginScreen.routeName);
                              // Navigator.of(context).pop();
                              Get.back();
                            },
                            child: Text(
                              "Login",
                              style: CustomTextStyles.f15W600(
                                  color: AppColors.primary),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
