import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../common/custom_text_style.dart';

class SkyRadioButton extends StatelessWidget {
  final String value;
  final String title;
  final String groupVlaue;
  final Function(String value) onTap;
  const SkyRadioButton({
    super.key,
    required this.value,
    required this.groupVlaue,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Row(
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColors.primary,
            value: value,
            fillColor:
                MaterialStateColor.resolveWith((states) => AppColors.primary),
            groupValue: groupVlaue,
            onChanged: (_) => onTap(value),
          ),
          Text(
            title,
            style: CustomTextStyles.f16W400(),
          )
        ],
      ),
    );
  }
}
