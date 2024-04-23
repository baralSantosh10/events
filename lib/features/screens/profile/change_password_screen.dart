import 'package:event/core/controllers/dashscreen/profile/profile_controller.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/helpers/validators.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  static const String routeName = "/change-pw-screen";
  final c = Get.find<ProfileController>();
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: c.resetPwKey,
            child: Column(
              children: [
                Obx(
                  () => PrimaryTextField(
                    hint: "Password",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
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
                  height: 10,
                ),
                Obx(
                  () => PrimaryTextField(
                    hint: "Confirm Password",
                    focusNode: c.conPassNode,
                    obscureText: !c.showConPass.value,
                    eyeClick: c.onConEyeClick,
                    controller: c.passwordConfirmController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.checkPasswordField,
                  ),
                ),
                const SizedBox(height: 60),
                PrimaryElevatedButton(
                  onPressed: c.onSubmit,
                  title: "Change Password",
                  textStyle:
                      CustomTextStyles.f16W600(color: AppColors.whiteColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
