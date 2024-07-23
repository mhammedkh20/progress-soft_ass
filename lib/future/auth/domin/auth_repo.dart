import 'package:progress_soft_ass/core/network/api.dart';
import 'package:progress_soft_ass/future/auth/models/country_model.dart';

abstract class AuthRepo {
  EitherType<CountryModel> getCurrentLocationDetails();
}
