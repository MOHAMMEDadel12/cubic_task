import 'package:cubic_task/core/rotues/route_animation.dart';
import 'package:cubic_task/core/rotues/route_keys.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:cubic_task/features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    SharedText.deepLinkUrl = settings.name.toString();

    debugPrint("the url is :  ${SharedText.deepLinkUrl}");

    switch (settings.name) {
      /// Login screen
      case RouteKeys.register:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const RegisterScreen(),
        );

      default:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const RegisterScreen(),
        );
    }
  }
}
