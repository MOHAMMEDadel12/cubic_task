import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';


class CommonErrorWidget extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final String errorMessage;

  const CommonErrorWidget(
      {super.key,
      required this.imageWidth,
      required this.imageHeight,
      required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonAssetSVGImage(
            width: imageWidth,
            height: imageHeight,
            imageName: ImagesPath.commonErrorIcon),

        /// Space
        const SizedBox(
          height: 8,
        ),
        CommonTextWidget(
            text: AppLocalizations.of(context)!.somethingWentWrong,
            fontSize: AppFontSize.s16.sp,
            textColor: AppColors.steel),

        /// Space
        const SizedBox(
          height: 8,
        ),
        CommonTextWidget(
            text: errorMessage,
            fontSize: AppFontSize.s12.sp,
            textColor: AppColors.steel),
      ],
    );
  }
}
