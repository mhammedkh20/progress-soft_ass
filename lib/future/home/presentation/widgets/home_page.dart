import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_ass/core/components/loading_widget.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/components/my_text_field.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/widgets/item_post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PostsFailuer) {
          AppHelpers.showSnackBar(context, message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const LoadingWidget();
        }
        if (state is PostsFailuer) {
          return Center(
            child: MyText(title: state.message),
          );
        }

        List<PostModel> posts = (state is SearchPostsState)
            ? state.searchResults
            : context.read<HomeBloc>().posts;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MyTextField(
                textHint: AppLocalizations.of(context)!.search_title,
                onChange: (String s) {
                  if (s.trim().isEmpty) {
                    context.read<HomeBloc>().add(SearchClearEvent());
                  } else {
                    context.read<HomeBloc>().add(SearchPostsByTitleEvent(s));
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return ItemPost(post: posts[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
