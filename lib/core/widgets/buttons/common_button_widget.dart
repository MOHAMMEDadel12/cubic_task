import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double borderRadius;
  final double textFontSize;
  final double? buttonWidth;
  final VoidCallback onTap;
  final bool isEnable;
  final bool hasBorder ;
  final double? textPadding;
  final Color? buttonColor;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.textFontSize,
    this.borderRadius = 4,
    required this.onTap,
    required this.isEnable,
    this.textPadding = 0,
    this.buttonWidth,
    this.hasBorder = false,

    this.buttonColor = AppColors.topaz,
    this.textColor = AppColors.generalWhite,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isEnable
        ? buttonColor // Color when enabled
        : AppColors.generalDarkBlue32; // Color when disabled

    return SizedBox(
      height: 48.h,
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: hasBorder ?  AppColors.generalDarkGrey.withOpacity(.15) : backgroundColor!,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: () {
          if (isEnable) {
            onTap();
          }
        },
        child: CommonTextWidget(
          text: text,
          fontWeight: AppFontWeights.fw500,
          textColor: textColor!,
          fontSize: textFontSize,
        ),
      ),
    );
  }
}
