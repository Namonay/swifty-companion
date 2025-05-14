import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkToken() async
{
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('user_token');
}

Future<void> saveToken(String token) async
{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token);
}

Future<String?> getToken() async
{
  final exists = await checkToken();
  if (exists) {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    return token;
  }
  return "";
}