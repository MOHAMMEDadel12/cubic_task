import 'package:flutter/material.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';

commonBottomSheet({
  required BuildContext context,
  required Widget widget,
}) {
  return showModalBottomSheet<void>(
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      elevation: 0.0,
      isDismissible: false,
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (BuildContext context) {
        return widget ;
        // return Scaffold(
        //     backgroundColor: AppColors.transparentColor,
        //     body: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: widget,
        //     ));
      });
}
