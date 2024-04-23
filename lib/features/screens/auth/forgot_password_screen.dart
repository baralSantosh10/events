import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/utils/helpers/validators.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth/forgot_controller.dart';
import '../../../core/widgets/common/text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot-pw-screen";
  final c = Get.find<ForgotPasswordController>();
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        automaticallyImplyLeading: true,
        title: Text(
          "Forgot Password",
          style: CustomTextStyles.f15W600(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: c.sendMailKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    IconPath.lockvector,
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "To Reset your password, Please enter your email address",
                    textAlign: TextAlign.center,
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Email",
                  style: CustomTextStyles.f16W400(color: AppColors.blackColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                PrimaryTextField(
                  hint: "example@gmail.com",
                  autofocus: true,
                  controller: c.emailController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkEmailField,
                ),
                const SizedBox(
                  height: 37,
                ),
                PrimaryElevatedButton(
                  onPressed: c.onSubmit,
                  title: "Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
