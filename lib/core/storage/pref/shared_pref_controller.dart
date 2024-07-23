import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_soft_ass/core/storage/pref/pref_keys.dart';

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();

  late SharedPreferences _preferences;

  SharedPrefController._internal();

  factory SharedPrefController() => _instance;

  Future<SharedPreferences> initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  SharedPreferences get prefManager => _preferences;

  Future<bool> setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(PrefKeys.PHONE_NUMBER, phoneNumber);

  String? get getPhoneNumber => _preferences.getString(PrefKeys.PHONE_NUMBER);

  Future<bool> setCountryCode(String code) async =>
      await _preferences.setString(PrefKeys.COUNTRY_CODE, code);

  String? get getCountryCode => _preferences.getString(PrefKeys.COUNTRY_CODE);

  Future clearAllData() async {
    await _preferences.clear();
  }
}
