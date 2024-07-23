import 'package:progress_soft_ass/core/network/api.dart';
import 'package:progress_soft_ass/future/auth/domin/auth_repo.dart';
import 'package:progress_soft_ass/future/auth/models/country_model.dart';

class AuthRepoImp extends AuthRepo {
  final Api api;

  AuthRepoImp({required this.api});

  @override
  EitherType<CountryModel> getCurrentLocationDetails() {
    return api.detailsCurrentLocation();
  }
}
