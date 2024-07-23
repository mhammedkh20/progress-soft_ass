import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';

class MyPinput extends StatelessWidget {
  final TextEditingController? textEditingController;
  const MyPinput({super.key, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.r,
      height: 50.r,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.WHITE2,
        border: Border.all(color: AppColors.BORDER, width: 2),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    final errorPinTheme = PinTheme(
      width: 50.r,
      height: 50.r,
      textStyle: const TextStyle(
          fontSize: 20, color: AppColors.RED, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.WHITE2,
        border: Border.all(color: AppColors.BORDER, width: 2),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: AppColors.BASE_COLOR.withOpacity(.05),
      border: Border.all(color: AppColors.BASE_COLOR),
      borderRadius: BorderRadius.circular(10.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        // decoration: defaultPinTheme.decoration.copyWith(
        //   color: Color.fromRGBO(234, 239, 243, 1),
        // ),
        );

    return Pinput(
      length: 6,
      controller: textEditingController,
      pinAnimationType: PinAnimationType.fade,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (s) {
        if (s == null || s.isEmpty) {
          return AppLocalizations.of(context)!.enterTheCode;
        }
        if (s.length != 6) {
          return AppLocalizations.of(context)!.enterTheCode;
        }
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      errorPinTheme: errorPinTheme,
      onCompleted: (pin) => print(pin),
    );
  }
}
