
import 'package:zartech/core/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

final String TAG = 'UserSimplePreferences';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;

  static Future init() async =>
      {log('init', TAG), _preferences = await SharedPreferences.getInstance()};

  static Future setToken(String token) async => {
        log('setToken -->>> ${token}', TAG),
        await _preferences?.setString(TOKEN, token)
      };

  static String? getToken() {
    return _preferences?.getString(TOKEN);
  }

  static Future setUserDetail(String value) async =>
      await _preferences?.setString(USER_DETAILS, value);

  static String? getUserDetail() {
    return (_preferences?.getString(USER_DETAILS) == null)
        ? ''
        : _preferences?.getString(USER_DETAILS);
  }

  static Future<bool?> logOut() async {
    log('logOut ${(_preferences?.clear() ?? false)}', TAG);
    var t = setUserDetail('');
    log("logOut ${"setUserDetail empty"}", TAG);
    log('logOut getUserDetail ${getUserDetail()}', TAG);
    log('${getUserDetail()}',TAG);
  }
}
