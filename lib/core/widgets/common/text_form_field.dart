import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/icon_paths.dart';

class PrimaryTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final String hint;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final String? suffixIconPath;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final bool showLable;
  final bool obscureText;
  final FocusNode? focusNode;
  final double borderRadius;
  final Function()? eyeClick;
  final List<TextInputFormatter>? inputFormatters;

  const PrimaryTextField({
    Key? key,
    required this.hint,
    this.prefixIconPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border = AppColors.borderColor,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.showLable = false,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.borderRadius = 6,
    this.eyeClick,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onTapOutside: (event) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          obscureText: obscureText,
          autofocus: autofocus!,
          textCapitalization: textCapitalization,
          onFieldSubmitted: onSubmitted,
          onTap: (onTap != null) ? onTap! : null,
          readOnly: (readOnly == null) ? false : readOnly!,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: 1,
          validator: (validator != null) ? validator : null,
          controller: (controller != null) ? controller : null,
          onChanged: (text) {
            if (onValueChange != null) {
              onValueChange!(text);
            }
          },
          decoration: InputDecoration(
            label: showLable
                ? Text(
                    hint,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
            fillColor: fillColor ?? AppColors.lightGrey,
            filled: true,
            prefixIconConstraints: const BoxConstraints(minWidth: 48),
            prefixIcon: (prefixIconPath != null)
                ? SvgPicture.asset(
                    prefixIconPath!,
                    fit: BoxFit.scaleDown,
                    colorFilter:
                        ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  )
                : prefixIcon,
            suffixIconConstraints: const BoxConstraints(minWidth: 48),
            suffixIcon: (eyeClick != null)
                ? InkWell(
                    onTap: eyeClick,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset(
                          fit: BoxFit.scaleDown,
                          !obscureText ? IconPath.eyeOff : IconPath.eyeOn),
                    ),
                  )
                : suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                width: 1,
                color: (border == null) ? Colors.transparent : border!,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                  width: 1, color: (border == null) ? Colors.red : border!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                  width: 1,
                  color: (border == null) ? AppColors.primary : border!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: const BorderSide(width: 1, color: Colors.red),
            ),
            errorStyle: (showError!)
                ? const TextStyle(fontSize: 12)
                : const TextStyle(fontSize: 0),
            hintText: hint,
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          style: const TextStyle(color: AppColors.blackColor),
        ),
      ],
    );
  }
}
