import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonFileImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const CommonFileImageWidget({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.file(
        fit: BoxFit.cover,
        width: width.w,
        height: height.h,
        File(imagePath),
      ),
    );
  }
}
