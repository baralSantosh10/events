import 'package:event/core/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth/reset_password_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_paths.dart';
import '../../../core/utils/helpers/validators.dart';
import '../../../core/widgets/common/custom_text_style.dart';
import '../../../core/widgets/common/text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = '/reset-password';

  final c = Get.find<ResetPasswordController>();
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Reset Password",
          style: CustomTextStyles.f15W600(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.resetPwKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    IconPath.lockvector,
                    height: 80,
                    width: 80,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Reset your password here",
                    style:
                        CustomTextStyles.f15W400(color: AppColors.blackColor),
                  ),
                ),
                const SizedBox(
                  height: 49,
                ),
                Text(
                  "Enter New Password",
                  style: CustomTextStyles.f16W400(color: AppColors.blackColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => PrimaryTextField(
                    hint: "Password",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    prefixIcon: SvgPicture.asset(
                      IconPath.unlock,
                    ),
                    focusNode: c.passNode,
                    obscureText: !c.showPass.value,
                    eyeClick: c.onEyeClick,
                    controller: c.passwordController,
                    validator: Validators.checkPasswordField,
                    onSubmitted: (_) {
                      c.conPassNode.requestFocus();
                    },
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Confirm Password",
                  style: CustomTextStyles.f16W400(color: AppColors.blackColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => PrimaryTextField(
                    hint: "Confirm Password",
                    focusNode: c.conPassNode,
                    obscureText: !c.showConPass.value,
                    eyeClick: c.onConEyeClick,
                    controller: c.passwordConController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      var checkPassword = Validators.checkPasswordField(value);
                      if (checkPassword != null) {
                        return checkPassword;
                      }

                      if (c.passwordController.text != value!) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    prefixIcon: SvgPicture.asset(
                      IconPath.unlock,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                PrimaryElevatedButton(
                    onPressed: () {
                      c.onReset();
                      // Get.toNamed(LoginScreen.routeName);
                    },
                    title: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
