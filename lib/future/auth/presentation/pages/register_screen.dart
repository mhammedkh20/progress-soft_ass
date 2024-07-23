import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progress_soft_ass/core/components/loading_widget.dart';
import 'package:progress_soft_ass/core/components/my_app_bar.dart';
import 'package:progress_soft_ass/core/components/my_drop_down_menu2.dart';
import 'package:progress_soft_ass/core/components/my_elevated_button.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/components/my_text_field.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:progress_soft_ass/future/auth/presentation/pages/otp_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fullNameField = TextEditingController();
  final TextEditingController phoneNumberField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final TextEditingController confirmedPasswordField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.register_screen),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          children: [
            MyText(
              title: AppLocalizations.of(context)!.can_you_register,
              fontSize: 24,
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: fullNameField,
              keyboardType: TextInputType.text,
              textHint: AppLocalizations.of(context)!.full_name,
              isBorder: true,
              validator: (String? s) {
                if (s!.isEmpty) {
                  return AppLocalizations.of(context)!.please_fill_input;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthGetLocationLoading) {
                      return const LoadingWidget();
                    }
                    return MyText(
                        title: context.read<AuthBloc>().countryCode ?? "");
                  },
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: MyTextField(
                    controller: phoneNumberField,
                    keyboardType: TextInputType.number,
                    textHint: AppLocalizations.of(context)!.phone_number,
                    isBorder: true,
                    validator: (String? s) {
                      if (s!.isEmpty) {
                        return AppLocalizations.of(context)!.please_fill_input;
                      }

                      if (s.length < 9 || s.length > 10) {
                        return AppLocalizations.of(context)!
                            .phone_number_ten_length;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(children: [
              MyText(title: AppLocalizations.of(context)!.age),
              SizedBox(width: 10.w),
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => (current is AuthChangeAge),
                  builder: (context, state) {
                    return NumberPicker(
                      value: context.read<AuthBloc>().age,
                      itemWidth: 40,
                      minValue: 10,
                      axis: Axis.horizontal,
                      maxValue: 100,
                      onChanged: (int value) {
                        context
                            .read<AuthBloc>()
                            .add(ChangeAgeEvent(age: value));
                      },
                    );
                  },
                ),
              ),
            ]),
            SizedBox(height: 20.h),
            Row(children: [
              MyText(title: AppLocalizations.of(context)!.gender),
              SizedBox(width: 10.w),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => (current is AuthChangeGender),
                builder: (context, state) {
                  return MyDropdownMenu2<String>(
                    initValue: context.read<AuthBloc>().gender,
                    isExpanded: false,
                    height: 40.h,
                    onChanged: (String? s) {
                      context
                          .read<AuthBloc>()
                          .add(ChangeGenderEvent(gender: s!));
                    },
                    items: [
                      DropdownMenuItem(
                        value: "male",
                        child: MyText(
                          title: AppLocalizations.of(context)!.male,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "female",
                        child: MyText(
                          title: AppLocalizations.of(context)!.female,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ]),
            SizedBox(height: 20.h),
            MyTextField(
              maxLines: 1,
              controller: passwordField,
              textHint: AppLocalizations.of(context)!.password,
              isBorder: true,
              obscureEnabled: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (String? s) {
                if (s!.isEmpty) {
                  return AppLocalizations.of(context)!.please_fill_input;
                }
                if (s.length < 8) {
                  return AppLocalizations.of(context)!.password_greater_than;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            MyTextField(
              maxLines: 1,
              controller: confirmedPasswordField,
              textHint: AppLocalizations.of(context)!.confirmed_password,
              isBorder: true,
              obscureEnabled: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (String? s) {
                if (s!.isEmpty) {
                  return AppLocalizations.of(context)!.please_fill_input;
                }
                if (s != passwordField.text) {
                  return AppLocalizations.of(context)!
                      .two_passwords_are_similar;
                }
                return null;
              },
            ),
            SizedBox(height: 34.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthRequestCodeFailuer) {
                  log(state.message!);
                  AppHelpers.showSnackBar(context,
                      message: state.message ?? "", error: true);
                }

                if (state is AuthRequestCodeSuccess) {
                  AppHelpers.navigationToPage(
                    context,
                    OtpScreen(
                      user: state.userModel,
                      verificationId: state.verificationId,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthRequestCodeLoading) {
                  return const LoadingWidget();
                }
                return MyElevatedButton(
                  title: AppLocalizations.of(context)!.register,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            RequestOTPCodeEvent(
                              phone: phoneNumberField.text.trim(),
                              password: passwordField.text.trim(),
                              name: fullNameField.text.trim(),
                            ),
                          );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
