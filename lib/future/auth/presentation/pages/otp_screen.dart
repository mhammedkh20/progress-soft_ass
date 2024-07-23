import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_ass/core/components/loading_widget.dart';
import 'package:progress_soft_ass/core/components/my_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_ass/core/components/my_elevated_button.dart';
import 'package:progress_soft_ass/core/components/my_pin_put.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/models/user_model.dart';
import 'package:progress_soft_ass/future/auth/presentation/manager/auth_bloc/auth_bloc.dart';

class OtpScreen extends StatelessWidget {
  final UserModel user;
  final String verificationId;
  final TextEditingController codeField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  OtpScreen({
    super.key,
    required this.user,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.otp_screen),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        children: [
          SizedBox(height: 40.h),
          MyText(
            title: AppLocalizations.of(context)!.text_verify_code,
            fontSize: 20,
          ),
          SizedBox(height: 60.h),
          Form(
            key: _formKey,
            child: MyPinput(textEditingController: codeField),
          ),
          SizedBox(height: 40.h),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthRegisterdFailuer) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
              if (state is AuthRegisterdSuccess) {
                AppHelpers.showSnackBar(
                  context,
                  message: AppLocalizations.of(context)!.registed_successfuly,
                );
                AppHelpers.navigationToPageAndExitAllWithoutFirst(context);
              }
            },
            builder: (context, state) {
              if (state is AuthRegisterdLoading) {
                return const LoadingWidget();
              }
              return MyElevatedButton(
                title: AppLocalizations.of(context)!.verify,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    log(codeField.text);
                    context.read<AuthBloc>().add(RegisterDataOnFirebaseEvent(
                        context: context,
                        userModel: user,
                        verificationId: verificationId,
                        smsCode: codeField.text));
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
