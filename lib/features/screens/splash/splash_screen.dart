import 'package:event/core/controllers/splash_controller.dart';
import 'package:event/core/utils/constants/image_path.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash-screen';
  final c = Get.find<SplashController>();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(IconPath.cupLogo),
            Image.asset(
              ImagePath.logo,
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Let us to handle events for you",
              style: CustomTextStyles.f16W600(color: AppColors.blackColor),
            )
          ],
        ),
      ),
    );
  }
}
