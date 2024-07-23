import 'package:flutter/material.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final double? leadingWidth;
  final Color textColor;
  final Color backgroundColor;
  final double? elevation;

  const MyAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title = '',
    this.leadingWidth,
    this.textColor = AppColors.WHITE,
    this.backgroundColor = AppColors.BASE_COLOR,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation ?? (title == '' ? 0 : 1),
      leading: leading,
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
      leadingWidth: leadingWidth,
      title: MyText(
        title: title,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
