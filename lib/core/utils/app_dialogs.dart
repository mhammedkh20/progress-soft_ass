import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_ass/core/components/my_elevated_button.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/presentation/pages/register_screen.dart';

class AppDialogs {
  static updateApplication(
    BuildContext context, {
    required Function()? onTap,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: MyText(title: 'تحديث التطبيق'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                title: 'لقد قمنا بإضافة ميزات جديدة على تطبيق',
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onTap,
                child: MyText(
                  title: 'حدث التطبيق',
                  fontSize: 20,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static registerDialog(BuildContext context) {
    showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content:
              MyText(title: AppLocalizations.of(context)!.you_can_subscribe),
          actions: [
            MyElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              title: AppLocalizations.of(context)!.cancel,
              background: AppColors.WHITE,
              titleColor: AppColors.RED,
            ),
            MyElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                AppHelpers.navigationToPage(context, RegisterScreen());
              },
              title: AppLocalizations.of(context)!.register_now,
            ),
          ],
        );
      },
    );
  }
}
