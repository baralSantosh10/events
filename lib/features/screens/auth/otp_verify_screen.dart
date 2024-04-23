import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/controllers/auth/otp_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_paths.dart';
import '../../../core/widgets/common/button.dart';
import '../../../core/widgets/common/custom_text_style.dart';

class OTPVerifyScreen extends StatelessWidget {
  static const String routeName = '/otp-verify';

  final c = Get.find<OtpVerifyController>();

  OTPVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: const TextStyle(
        fontSize: 18,
        color: AppColors.blackColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.blackColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "OTP Verify",
          style: CustomTextStyles.f15W600(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: c.otpKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      IconPath.forgotpw,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Text(
                    "Enter the verification code that was provided to your email address",
                    textAlign: TextAlign.center,
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: 5,
                          controller: c.pinController,
                          focusNode: c.focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          validator: (value) {
                            // return value == '1234' ? null : '';
                          },
                          // onClipboardFound: (value) {
                          //   debugPrint('onClipboardFound: $value');
                          //   pinController.setText(value);
                          // },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');

                            print("------${c.pinController.text}");
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');

                            print("------>>${c.pinController.text}");
                          },

                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: AppColors.green, width: 2),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.blackColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryElevatedButton(
                        onPressed: c.verifyOtp,
                        title: "Submit",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive code ?",
                            style: CustomTextStyles.f15W600(
                                color: AppColors.blackColor),
                          ),
                          Obx(() {
                            if (c.remainingTime.value == 0) {
                              return TextButton(
                                onPressed: c.resendOtp,
                                child: Text(
                                  "Resend Code",
                                  style: CustomTextStyles.f15W600(
                                      color: AppColors.primary),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Resend in ${c.remainingMinutes.value} : ${c.remainingSeconds.value}",
                                  style: CustomTextStyles.f16W400(
                                      color: AppColors.green),
                                ),
                              );
                            }
                          })
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
