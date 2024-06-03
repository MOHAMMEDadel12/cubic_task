import 'package:flutter/material.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';

import '../../utils/constants/font_weights.dart';

class CommonButtonInvite extends StatelessWidget {
  final String text;
  final double borderRadius;
  final double textFontSize;
  final VoidCallback onTap;
  final String icon;

  const CommonButtonInvite({
    super.key,
    required this.text,
    required this.textFontSize,
    this.borderRadius = 4,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(1, .1),
          colors: [
            AppColors.cerise.withOpacity(.5),
            AppColors.topaz.withOpacity(.5),
            // add more colors
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: MaterialButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonAssetSVGImage(
              imageName: ImagesPath.inviteUser,
              width: 16,
              height: 22,
            ),
            const SizedBox(
              width: 5,
            ),
            CommonTextWidget(
              text: text,
              fontSize: textFontSize,
              textColor: AppColors.generalWhite,
              fontWeight: AppFontWeights.fw400,
            ),
          ],
        ),
      ),
    );
  }
}
