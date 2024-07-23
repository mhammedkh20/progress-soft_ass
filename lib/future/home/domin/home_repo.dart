import 'package:progress_soft_ass/core/network/api.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';

abstract class HomeRepo {
  EitherType<List<PostModel>> getPosts();
}
