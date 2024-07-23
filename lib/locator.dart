import 'package:get_it/get_it.dart';
import 'package:progress_soft_ass/core/network/api.dart';
import 'package:progress_soft_ass/core/services/dio_service.dart';
import 'package:progress_soft_ass/core/services/navigation_service.dart';
import 'package:progress_soft_ass/future/auth/data/auth_repo_imp.dart';
import 'package:progress_soft_ass/future/auth/domin/auth_repo.dart';
import 'package:progress_soft_ass/future/home/data/home_repo_imp.dart';
import 'package:progress_soft_ass/future/home/domin/home_repo.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DioService());

  Api api = Api(dio: locator<DioService>());
  locator.registerFactory<AuthRepo>(() => AuthRepoImp(api: api));
  locator.registerFactory<HomeRepo>(() => HomeRepoImp(api: api));
}
