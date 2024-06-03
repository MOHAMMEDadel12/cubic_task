import 'dart:convert';
import 'dart:io';

import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/core/rotues/route_keys.dart';
import 'package:cubic_task/core/utils/constants/colors.dart';
import 'package:cubic_task/core/utils/constants/enums/toast_status_enum.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/utils/constants/padding.dart';
import 'package:cubic_task/core/widgets/errors/common_server_error_widget.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Helpers {
  static void showCommonSnackBar(
      BuildContext context, String message, SnackBarStatus snackBarStatus,
      {bool showDescription = false, String? descriptionMessage = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.endToStart,
        backgroundColor: chooseSnackBarColor(snackBarStatus),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        content: Row(
          children: [
            snackBarStatus == SnackBarStatus.error
                ? const CommonAssetSVGImage(imageName: ImagesPath.errorState)
                : snackBarStatus == SnackBarStatus.waring
                    ? const CommonAssetSVGImage(imageName: ImagesPath.errorIcon)
                    : const CommonAssetSVGImage(
                        imageName: ImagesPath.successSnackIcon),

            const SizedBox(width: 10), // Add spacing between icon and text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    fontSize: AppFontSize.s14.sp,
                    fontWeight: AppFontWeights.fw500,
                    text: message,
                    textColor: AppColors.generalWhite,
                    maxLines: 2,
                    softWrap: true,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  showDescription
                      ? CommonTextWidget(
                          maxLines: 2,
                          softWrap: true,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: AppFontSize.s14.sp,
                          text: descriptionMessage!,
                          textColor: AppColors.generalWhite,
                          fontWeight: AppFontWeights.fw400,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }

  static Color chooseSnackBarColor(SnackBarStatus status) {
    Color color;
    switch (status) {
      case SnackBarStatus.success:
        color = AppColors.successDefault;
        break;
      case SnackBarStatus.waring:
        color = AppColors.warningDefault;
        break;
      case SnackBarStatus.error:
        color = AppColors.errorDefault;
    }
    return color;
  }

  /// Loader Widget
  static void showLoaderWidget(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: true,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(AppPadding.p80),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            insetPadding: EdgeInsets.zero,
            content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                )),
          ),
        );
      },
    );
  }

  /// Convert Files To 64
  static String convertFilesToBase64({required String filePath}) {
    final bytes = File(filePath).readAsBytesSync();
    String file64 = base64.encode(bytes);
    return file64;
  }

  /// Check User Auth Function
  static checkUserAuth({
    required BuildContext context,
    required CustomError error,
  }) {
    if (error.statusCode == 401) {
      SharedPreference.clearLocalStorage();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteKeys.login,
        (route) => false,
      );
    } else {
      Helpers.showCommonSnackBar(
        context,
        error.errorMessage,
        SnackBarStatus.error,
      );
    }
  }

  /// Show Error In Get Case
  static showErrorInGetCaseOrConnection({
    required BuildContext context,
    required CustomError error,
    required VoidCallback onTap,
  }) {
    if (error.statusCode == 401) {
      SharedPreference.clearLocalStorage();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteKeys.login,
        (route) => false,
      );
    } else {
      return CommonServerErrorWidget(
        errorMessage: error.errorMessage,
        onTap: onTap,
      );
    }
  }

  /// Copy Text When Click
  static copyTextWhenCLick({required String text}) {
    Clipboard.setData(ClipboardData(
      text: text,
    ));
  }

  /// Hide Keyboard After Finish Typing
  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
