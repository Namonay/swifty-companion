import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> checkToken() async
{
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user_token') == false) { return false; }
  final date = DateTime.fromMillisecondsSinceEpoch(prefs.getInt('expiration') ?? 0);
  return date.isAfter(DateTime.now());
}

Future<Map<String, dynamic>> fetchProfileData(String login) async
{
  final uri = Uri.https(
    'api.intra.42.fr',
    '/v2/users/$login',
  );
  final token = await getToken() ?? '';
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
  else { throw Exception('Failed to fetch user: ${response.statusCode}'); }
}

Future<void> saveToken(String token, String refresh, DateTime expiration) async
{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token);
  await prefs.setString('refresh_token', refresh);
  await prefs.setInt('expiration', expiration.millisecondsSinceEpoch);
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