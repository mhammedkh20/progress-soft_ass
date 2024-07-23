import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progress_soft_ass/core/components/loading_widget.dart';
import 'package:progress_soft_ass/core/components/my_drop_down_menu2.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/components/my_text_field.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/home_bloc/home_bloc.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetUserLoading || context.read<HomeBloc>().user == null) {
          return const LoadingWidget();
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              MyTextField(
                controller: TextEditingController(
                    text: context.read<HomeBloc>().user!.name),
                textHint: AppLocalizations.of(context)!.full_name,
                labelText: AppLocalizations.of(context)!.full_name,
                readOnly: true,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  MyText(title: context.read<HomeBloc>().user!.countryCode),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MyTextField(
                      controller: TextEditingController(
                          text: context.read<HomeBloc>().user!.phoneNumber),
                      textHint: AppLocalizations.of(context)!.phone_number,
                      labelText: AppLocalizations.of(context)!.phone_number,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  MyText(title: AppLocalizations.of(context)!.gender),
                  SizedBox(width: 10.w),
                  MyDropdownMenu2<String>(
                    initValue: context.read<HomeBloc>().user!.gender,
                    isExpanded: false,
                    height: 40.h,
                    onChanged: null,
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
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(children: [
                MyText(title: AppLocalizations.of(context)!.age),
                SizedBox(width: 10.w),
                Expanded(
                  child: NumberPicker(
                    value: context.read<HomeBloc>().user!.age,
                    itemWidth: 40,
                    minValue: 10,
                    axis: Axis.horizontal,
                    maxValue: 100,
                    onChanged: (int value) {},
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}
