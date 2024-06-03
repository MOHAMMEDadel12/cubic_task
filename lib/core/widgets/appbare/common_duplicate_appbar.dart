import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';

class CommonDuplicateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonDuplicateAppBar({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.paleGrey,
      forceMaterialTransparency: true,
       leadingWidth:0 ,
        leading: const SizedBox(),
      title: Row(
        children: [
          /// Left arrow Icon
          InkWell(
            onTap: onPressed,
            child: CommonAssetSVGImage(
                imageColor: AppColors.generalDarkGrey,
                height: 24.h, width: 24.w, imageName: ImagesPath.arrowLeftIcon),
          ),
          /// Space

          SizedBox(width: 16.w,),
          /// Title
          CommonTextWidget(
            text:text ,
            fontSize: AppFontSize.s20.sp,
            textColor: AppColors.generalDarkGrey,
            fontWeight: AppFontWeights.fw500,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
