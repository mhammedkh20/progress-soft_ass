import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_ass/app_config.dart';
import 'package:progress_soft_ass/core/services/navigation_service.dart';
import 'package:progress_soft_ass/core/services/notification_service.dart';
import 'package:progress_soft_ass/core/storage/pref/shared_pref_controller.dart';
import 'package:progress_soft_ass/firebase_options.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/language_bloc/language_bloc.dart';
import 'package:progress_soft_ass/future/on_boarding/presentation/splash_screen.dart';
import 'package:progress_soft_ass/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefController().initSharedPref();
  await NotificationService().initNotification();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.blocs,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Flutter Task',
                theme: AppConfig.themeData(),
                debugShowCheckedModeBanner: false,
                navigatorKey: locator<NavigationService>().rootNavKey,
                localizationsDelegates: AppConfig.localization(),
                supportedLocales: AppConfig.supportedLocales(),
                locale: Locale(state.lang),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
