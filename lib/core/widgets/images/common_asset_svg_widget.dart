import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAssetSVGImage extends StatelessWidget {
  final String imageName;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  final Color? imageColor;

  const CommonAssetSVGImage({
    super.key,
    this.width,
    this.height,
    required this.imageName,
    this.imageColor,
    this.boxFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (imageColor == null) {
      return SvgPicture.asset(
        imageName,
        fit: boxFit,
        height: height,
        width: width,
      );
    } else {
      return SvgPicture.asset(
        imageName,
        fit: boxFit,
        height: height,
        width: width,
        colorFilter: ColorFilter.mode(imageColor!, BlendMode.srcIn),
      );
    }
  }
}
