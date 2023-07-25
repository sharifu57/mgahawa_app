import 'package:shared_preferences/shared_preferences.dart';

Future<String?> checkUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? accessToken = pref.getString('_accessToken');
  return accessToken;
}
