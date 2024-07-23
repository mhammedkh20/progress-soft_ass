import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/storage/pref/shared_pref_controller.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/presentation/pages/login_screen.dart';
import 'package:progress_soft_ass/future/home/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (SharedPrefController().getPhoneNumber != null) {
        AppHelpers.navigationToPageAndExitAll(context, const MainScreen());
      } else {
        AppHelpers.navigationToPageAndExitAll(context, LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/ic_app.png',
              width: 120.w,
            ),
          ),
          PositionedDirectional(
            bottom: 10.h + MediaQuery.of(context).padding.bottom,
            start: 0,
            end: 0,
            child: MyText(
              title: "© 2024 ProgressSoft",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
