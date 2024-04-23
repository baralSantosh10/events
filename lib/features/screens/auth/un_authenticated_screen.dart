
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_paths.dart';
import '../../../core/widgets/common/button.dart';
import '../../../core/widgets/common/custom_text_style.dart';
import 'login_screen.dart';

class UnAuthenticatedScreen extends StatelessWidget {
  const UnAuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconPath.unAuth,
                fit: BoxFit.contain,
                height: Get.height / 3,
              ),
              Text(
                'Please login to continue',
                style: CustomTextStyles.f14W600(),
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryOutlineButton(
                width: 100,
                onPressed: () {
                  Get.toNamed(LoginScreen.routeName);
                },
                title: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
