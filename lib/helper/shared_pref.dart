import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final log = Logger('SharedPref');

class SharedPref {
  static final SharedPref instance = SharedPref._();
  SharedPref._();

  static Future<bool?> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_launch');
  }

  static Future<bool> finishFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('first_launch', false);
  }

  static Future<String?> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  static Future<void> saveLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
  }
}
