import 'package:shared_preferences/shared_preferences.dart';

final key = 'score';

Future<dynamic> readScore() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(key) ?? 0;
  print('read $value');
  return value;
}

Future<bool> saveScore(int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
  print('saved $value');
  return true;
}
