import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:progress_soft_ass/core/network/end_points.dart';
import 'package:progress_soft_ass/core/services/dio_service.dart';
import 'package:progress_soft_ass/future/auth/models/country_model.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';

typedef EitherType<T> = Future<Either<String, T>>;

class Api {
  final DioService dio;

  Api({required this.dio});

  EitherType<List<PostModel>> posts() async {
    try {
      final response = await dio.dio.get(EndPoints.POSTS);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<PostModel> posts = [];
        response.data.forEach((v) {
          posts.add(PostModel.fromMap(v));
        });
        return right(posts);
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<CountryModel> detailsCurrentLocation() async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: "http://ip-api.com",
        followRedirects: false,
        validateStatus: (int? status) {
          return status! < 500;
        },
      )).get("/json");
      if (response.statusCode == 200) {
        return right(CountryModel.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
