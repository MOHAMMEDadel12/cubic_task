import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';

import '../../utils/constants/padding.dart';

class CommonSearchFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String hintText;
  final TextEditingController? controller;
  final Color imageColor;

  const CommonSearchFormField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.onFieldSubmitted,
    this.controller,
    this.imageColor=AppColors.generalDarkGrey,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: AppFontSize.s12.sp,
        fontWeight: AppFontWeights.fw400,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p24,
          vertical: AppPadding.p10,
        ),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 25.w,
          maxHeight: 25.h,
        ),
        prefixIcon: Padding(
          padding:   EdgeInsets.only(right: AppPadding.p8.sp, ),
          child: CommonAssetSVGImage(
            imageColor: imageColor,
            imageName: ImagesPath.searchIcon,
            height: 25.h,
            width: 25.w,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.lightGrey100,
          ),
        ),
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          borderSide: BorderSide(width: 1, color: AppColors.lightGrey100),
        ),
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        hintText: hintText,
        fillColor: AppColors.generalWhite,
        hintStyle: TextStyle(
            fontSize: AppFontSize.s14.sp,
            fontWeight: AppFontWeights.fw400,
            color: AppColors.steel.withOpacity(0.6)),
        filled: true,
      ),
    );
  }
}
