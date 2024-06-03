import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextOverflow textOverflow;
  final bool softWrap;
  final bool underLine;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final String fontFamily;

  const CommonTextWidget({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.visible,
    this.softWrap = false,
    this.underLine = false,
    this.fontFamily = SharedText.fontFamily,
    this.fontWeight = AppFontWeights.fw400,
    required this.fontSize,
    required this.textColor,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: softWrap,
      textAlign: textAlign,
      style: TextStyle(
        decoration: underLine ? TextDecoration.underline : TextDecoration.none,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor,
      ),
    );
  }
}
