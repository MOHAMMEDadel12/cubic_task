import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/padding.dart';
import 'package:cubic_task/core/widgets/buttons/common_button_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CommonServerErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onTap;

  const CommonServerErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          CommonTextWidget(
            maxLines: 2,
            text: errorMessage,
            fontSize: AppFontSize.s16.sp,
            textOverflow: TextOverflow.ellipsis,
            textColor: AppColors.generalDarkGrey,
            fontWeight: AppFontWeights.fw400,
          ),

          /// Space
          SizedBox(height: 24.h),

          /// Try Again
          CommonButton(
            buttonWidth: 202.w,
            text: AppLocalizations.of(context)!.tryAgain,
            textFontSize: 14.sp,
            onTap: onTap,
            isEnable: true,
          )
          // Add spacing between text and button
          ,
        ],
      ),
    );
  }
}
