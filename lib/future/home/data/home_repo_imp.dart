import 'package:progress_soft_ass/core/network/api.dart';
import 'package:progress_soft_ass/future/home/domin/home_repo.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';

class HomeRepoImp extends HomeRepo {
  final Api api;

  HomeRepoImp({required this.api});

  @override
  EitherType<List<PostModel>> getPosts() {
    return api.posts();
  }
}
