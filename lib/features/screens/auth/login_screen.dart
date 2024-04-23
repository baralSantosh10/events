import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/image_path.dart';
import 'package:event/core/utils/helpers/validators.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/features/screens/auth/forgot_password_screen.dart';
import 'package:event/features/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth/login_controller.dart';
import '../../../core/widgets/common/text_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<LoginController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                ImagePath.logo,
                // height: 500,
                fit: BoxFit.fitWidth,
                width: Get.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: c.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: CustomTextStyles.f20W500(color: AppColors.primary),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Email Address",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    PrimaryTextField(
                      hint: "Email Address",
                      controller: c.emailController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      validator: Validators.checkEmailField,
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
                        hint: "Password",

                        obscureText: !c.showPass.value,
                        controller: c.passwordController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.checkPasswordField,
                        eyeClick: c.onEyeClick,

                        // prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Get.toNamed(ForgotPasswordScreen.routeName);
                        },
                        radius: 10,
                        child: Text(
                          "Forgot Password?",
                          style: CustomTextStyles.f16W600(
                              color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PrimaryElevatedButton(
                      // onPressed: () {
                      //   // Get.toNamed(RegisterScreen.routeName);
                      //   Get.toNamed(DashPageManager.routeName);
                      // },
                      onPressed: c.onSubmit,
                      title: "Login",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: CustomTextStyles.f15W600(
                              color: AppColors.blackColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            "Create one",
                            style: CustomTextStyles.f15W600(
                                color: AppColors.primary),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
