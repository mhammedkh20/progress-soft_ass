// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:progress_soft_ass/future/auth/domin/auth_repo.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/language_bloc/language_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/main_bloc/main_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/future/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:progress_soft_ass/future/home/domin/home_repo.dart';
import 'package:progress_soft_ass/locator.dart';

class AppConfig {
  static ThemeData themeData() {
    return ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.WHITE,
        buttonTheme: const ButtonThemeData(buttonColor: AppColors.BASE_COLOR));
  }

  static Iterable<LocalizationsDelegate<dynamic>> localization() {
    return [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  static Iterable<Locale> supportedLocales() {
    return const [
      Locale('en'),
      Locale('ar'),
    ];
  }

  static List<SingleChildWidget> blocs = [
    BlocProvider(create: (_) => MainBloc()),
    BlocProvider(create: (_) => HomeBloc(locator<HomeRepo>())),
    BlocProvider(create: (_) => LanguageBloc()),
    BlocProvider(create: (_) => AuthBloc(locator<AuthRepo>())),
  ];
}
