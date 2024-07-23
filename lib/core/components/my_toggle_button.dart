import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_ass/core/components/my_contianer_shape.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/main_bloc/main_bloc.dart';

class MyTapBar extends StatelessWidget {
  final String? title;
  final List<String> values;
  final Color background;
  final bool isBorder;
  final int indexSelected;
  final double fontSize;

  const MyTapBar({
    super.key,
    required this.title,
    required this.values,
    required this.indexSelected,
    this.fontSize = 14,
    this.background = AppColors.WHITE4,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            MyText(
              title: title!,
              maxLines: 1,
              textOverflow: true,
            ),
          Flexible(
            child: MyContainerShape(
              paddingHorizontal: 5,
              paddingVertical: 5,
              borderRadius: 4,
              bgContainer: background,
              enableBorder: isBorder,
              height: 55.h,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<MainBloc>().add(const MainEvent(0));
                      },
                      child: MyContainerShape(
                        height: double.infinity,
                        bgContainer: indexSelected == 0
                            ? AppColors.GRAY3
                            : AppColors.TRANSPARENT,
                        borderRadius: 4,
                        child: MyText(
                          fontSize: fontSize,
                          title: values[0],
                          fontWeight: indexSelected == 0
                              ? FontWeight.w400
                              : FontWeight.w300,
                          color: indexSelected == 0
                              ? AppColors.WHITE
                              : AppColors.GRAY3,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<MainBloc>().add(const MainEvent(1));
                      },
                      child: MyContainerShape(
                        height: double.infinity,
                        bgContainer: indexSelected == 1
                            ? AppColors.GRAY3
                            : AppColors.TRANSPARENT,
                        borderRadius: 4,
                        child: MyText(
                          fontSize: fontSize,
                          title: values[1],
                          fontWeight: indexSelected == 1
                              ? FontWeight.w400
                              : FontWeight.w300,
                          color: indexSelected == 1
                              ? AppColors.WHITE
                              : AppColors.GRAY3,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
