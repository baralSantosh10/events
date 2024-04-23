import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/colors.dart';
import 'custom_text_style.dart';

class PrimaryOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final String title;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final double radius;
  final Color? color;
  final double? width;
  final double height;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  const PrimaryOutlineButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.suffixIconPath,
    this.prefixIconPath,
    this.radius = 5,
    this.color,
    this.isDisabled = false,
    this.height = 50,
    this.textStyle,
    this.style,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: style ??
            OutlinedButton.styleFrom(
                side: BorderSide(color: color ?? AppColors.primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                minimumSize: width == null
                    ? Size.fromHeight(height)
                    : Size(width!, height),
                fixedSize: width != null ? Size(width!, height) : null),
        onPressed: (isDisabled)
            ? null
            : () {
                if (isLoading) return;
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                onPressed!();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIconPath != null) //prefixIconPath
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  prefixIconPath!,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                ),
              ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                : SizedBox(
                    height: 16,
                    child: FittedBox(
                      child: Text(
                        title,
                        style: textStyle ??
                            CustomTextStyles.f16W600(color: AppColors.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
            if (suffixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  suffixIconPath!,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                ),
              )
          ],
        ));
  }
}

class PrimaryElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final String title;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final double radius;
  final Color? color;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  const PrimaryElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.suffixIconPath,
    this.prefixIconPath,
    this.radius = 12,
    this.color,
    this.isDisabled = false,
    this.height = 50,
    this.textStyle,
    this.width,
    this.style,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: style ??
            ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                minimumSize: width == null
                    ? Size.fromHeight(height)
                    : Size(width!, height),
                fixedSize: width != null ? Size(width!, height) : null),
        onPressed: (isDisabled)
            ? null
            : () {
                if (isLoading) return;
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                onPressed!();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIconPath != null) //prefixIconPath
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  prefixIconPath!,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : SizedBox(
                    height: 16,
                    child: FittedBox(
                      child: Text(
                        title,
                        style: textStyle ??
                            CustomTextStyles.f16W600(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
            if (suffixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  suffixIconPath!,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              )
          ],
        ));
  }
}
