import 'package:shared_preferences/shared_preferences.dart';

class AppInit {
  static Future<SharedPreferences> initializeApp() async {
    return await SharedPreferences.getInstance();
  }
}