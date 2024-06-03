import 'package:cubic_task/core/cubits/Language_Cubit/language_cubit.dart';
import 'package:cubic_task/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:cubic_task/features/authentication_feature/presentation/logic/register_cubit/register_cubit.dart';

import 'package:cubic_task/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({super.key, required this.body});

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Language Cubit
        BlocProvider<LanguageCubit>(
          create: (_) => getIt<LanguageCubit>()..getLang(),
        ),

        /// Theme Cubit
        BlocProvider<ThemeCubit>(
          create: (_) => getIt<ThemeCubit>()..getTheme(),
        ),

        BlocProvider<RegisterCubit>(
          create: (_) => getIt<RegisterCubit>(),
        ),
      ],
      child: widget.body,
    );
  }
}
