import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_soft_ass/core/components/loading_widget.dart';
import 'package:progress_soft_ass/core/components/my_app_bar.dart';
import 'package:progress_soft_ass/core/components/my_contianer_shape.dart';
import 'package:progress_soft_ass/core/components/my_elevated_button.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/components/my_text_field.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/core/utils/app_dialogs.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:progress_soft_ass/future/auth/presentation/pages/register_screen.dart';
import 'package:progress_soft_ass/future/home/presentation/pages/main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberField = TextEditingController();

  final TextEditingController passwordField = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<AuthBloc>().add(GetLocationDetaisEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.login_screen),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          children: [
            Align(
              child: MyContainerShape(
                enableRadius: true,
                borderRadius: 100,
                width: 100.r,
                height: 100.r,
                child: Image.asset(
                  'assets/images/ic_app.png',
                  width: 100.r,
                  height: 100.r,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            MyText(
              title: AppLocalizations.of(context)!.wellcome_back,
              fontSize: 24,
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: phoneNumberField,
              keyboardType: TextInputType.number,
              textHint: AppLocalizations.of(context)!.phone_number,
              isBorder: true,
              validator: (String? s) {
                if (s!.isEmpty) {
                  return AppLocalizations.of(context)!.please_fill_input;
                }
                return null;
              },
            ),
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${AppLocalizations.of(context)!.can_you_register} ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      fontSize: 12.sp,
                      color: AppColors.SECANDRY_COLOR,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => AppHelpers.navigationToPage(
                          context, RegisterScreen()),
                    text: AppLocalizations.of(context)!.register_now,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.BASE_COLOR,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 34.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginSuccess) {
                  AppHelpers.navigationToPageAndExitAll(
                      context, const MainScreen());
                }
                if (state is AuthLoginFailuer) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }
                if (state is UserIsNotRegister) {
                  AppDialogs.registerDialog(context);
                }
              },
              builder: (context, state) {
                if (state is AuthLoginLoading) {
                  return const LoadingWidget();
                }
                return MyElevatedButton(
                  title: AppLocalizations.of(context)!.login,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LoginEvent(
                          context: context,
                          phoneNumber: phoneNumberField.text.trim(),
                          password: passwordField.text.trim()));
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
