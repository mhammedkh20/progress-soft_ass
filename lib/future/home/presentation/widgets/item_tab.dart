import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_ass/core/components/my_contianer_shape.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';

class ItemTap extends StatelessWidget {
  final bool isSelected;
  final String title;
  final IconData icon;
  final Function()? onTap;

  const ItemTap({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24.r),
                SizedBox(width: 6.w),
                MyText(
                  title: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: AppColors.BLACK,
                )
              ],
            ),
            const Spacer(),
            isSelected
                ? MyContainerShape(
                    height: 2.h,
                    width: 100.w,
                    bgContainer:
                        isSelected ? AppColors.BASE_COLOR : AppColors.WHITE,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
