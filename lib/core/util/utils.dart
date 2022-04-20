import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

String dateConverter1(String date, String inFormat, String outFormat) {
  var _date = '';
  var inputFormat = DateFormat(inFormat);
  var inputDate = inputFormat.parse(date);

  /// outputFormat - convert into format you want to show.
  var outputFormat = DateFormat(outFormat);
  _date = outputFormat.format(inputDate);
  return _date;
}

String dateConverter(String date) {
  var _date = '';

  var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  var inputDate = inputFormat.parse(date);

  /// outputFormat - convert into format you want to show.
  var outputFormat = DateFormat('yyyy-MM-dd');
  _date = outputFormat.format(inputDate);
  return _date;
}

Future setStringPreference(String key, String value) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getStringPreference(String key) async {
  var prefs = await SharedPreferences.getInstance();
  var stringValue = prefs.getString(key);
  return stringValue;
}

Future<bool?> setBoolPreference(String key, bool value) async {
  var prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(key, value);
}

Future<bool?> getBoolPreference(String key) async {
  var prefs = await SharedPreferences.getInstance();
  var value = prefs.getBool(key);
  return value;
}

Future<bool?> isUserLoggedIn() async {
  return await getBoolPreference(IS_USER_LOGGED);
}

/* LOGGING */
void log(String value, String? tag) {
  if (tag != null) {
    Logger.root.log(Level.ALL, '<<<<TAG $tag>>>> ');
    Logger.root.log(Level.ALL, value);
  } else {
    Logger.root.log(Level.ALL, value);
  }
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
