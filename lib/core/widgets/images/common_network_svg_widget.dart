import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonNetworkSVGImage extends StatelessWidget {
  final String imageName;
  final double height;
  final double width;
  final BoxFit boxFit;
  final Color? color;

  const CommonNetworkSVGImage({
    super.key,
    required this.width,
    required this.height,
    required this.imageName,
    this.boxFit = BoxFit.contain,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageName,
      fit: boxFit,
      height: height,
      width: width,
      colorFilter: ColorFilter.mode(
        color!,
        BlendMode.srcIn,
      ),
    );
  }
}
