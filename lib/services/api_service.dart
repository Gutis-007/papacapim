import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://api.papacapim.just.pro.br';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<http.Response> register(String name, String email, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    return response;
  }

  Future<http.Response> createPost(String content) async {
    final token = await getToken();
    return await http.post(
      Uri.parse('$baseUrl/posts'),
      body: jsonEncode({'content': content}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> getFeed() async {
    final token = await getToken();
    return await http.get(
      Uri.parse('$baseUrl/feed'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}