import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_ass/core/components/my_contianer_shape.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';

class ItemPost extends StatelessWidget {
  final PostModel post;
  const ItemPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      enableBorder: true,
      enableRadius: true,
      enableShadow: true,
      borderRadius: 10,
      paddingHorizontal: 14,
      shadow: AppColors.BASE_COLOR.withOpacity(.1),
      marginBottom: 15,
      paddingVertical: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(title: post.id.toString()),
          SizedBox(height: 5.h),
          MyText(title: post.userId.toString()),
          SizedBox(height: 5.h),
          if (post.title != null) ...[
            MyText(title: post.title!),
            SizedBox(height: 5.h),
          ],
          if (post.body != null) ...[
            MyText(title: post.body!),
            SizedBox(height: 5.h),
          ],
        ],
      ),
    );
  }
}
