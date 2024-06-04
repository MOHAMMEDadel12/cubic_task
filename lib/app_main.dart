import 'package:cubic_task/core/cubits/Language_Cubit/language_cubit.dart';
import 'package:cubic_task/core/cubits/Language_Cubit/language_states.dart';
import 'package:cubic_task/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:cubic_task/core/cubits/theme_cubit/theme_states.dart';
import 'package:cubic_task/core/rotues/route_generator.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:cubic_task/core/utils/themes/dark_theme.dart';
import 'package:cubic_task/core/utils/themes/light_theme.dart';
import 'package:cubic_task/features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:cubic_task/multi_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    bool isBackground = state == AppLifecycleState.paused;
    bool isVisible = state == AppLifecycleState.resumed;
    if (isBackground) {
      if (SharedText.userToken.isNotEmpty) {
        //    SocketCubit.stopSocket();
        //    SocketCubit.initializeService();
      }
    } else if (isVisible) {
      if (SharedText.userToken.isNotEmpty) {
        //  SocketCubit.stopService();
        //     SocketCubit.initSocket();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: MultiBlocProvidersPage(
        body: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (languageContext, languageState) {
            return BlocBuilder<ThemeCubit, ThemeStates>(
              builder: (themeContext, themeState) {
                return ScreenUtilInit(
                  designSize: const Size(375, 812),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Cubic Task',
                    onGenerateRoute: RouteGenerator.generateRoute,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: LanguageCubit.get(languageContext).appLocal,
                    theme: ThemeCubit.get(themeContext).isLight
                        ? lightTheme
                        : darkTheme,
                    home: const RegisterScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
