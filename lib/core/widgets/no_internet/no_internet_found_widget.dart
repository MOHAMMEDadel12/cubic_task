import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';

import '../../utils/constants/padding.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';

class NoInternetFoundWidget extends StatelessWidget {
  const NoInternetFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.generalWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Image
          const CommonAssetSVGImage(imageName: ImagesPath.noInternetIcon),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              children: [
                /// Title
                CommonTextWidget(
                  text: "Whoops!",
                  fontSize: AppFontSize.s36.sp,
                  textColor: AppColors.generalBlack,
                  fontWeight: FontWeight.bold,
                ),

                /// Space
                const SizedBox(
                  height: 24,
                ),

                /// Description
                CommonTextWidget(
                  softWrap: true,
                  text:
                      "Re-connect your internet to access this part of the app.",
                  fontSize: AppFontSize.s16.sp,
                  textColor: AppColors.generalBlack,
                  fontWeight: AppFontWeights.fw300,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
