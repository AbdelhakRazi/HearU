import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hearu/services/authentication/authentication_service.dart';

class SpringAuthService extends AuthenticationService {
  final String baseUrl; // Your Spring API base URL

  SpringAuthService({required this.baseUrl});

  @override
  Future<String> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['token'] != null) {
        return data['token'];
      } else {
        throw Exception("Token not found in the response");
      }
    } else {
      throw Exception("Invalid login credentials: ${response.body}");
    }
  }

  @override
  Future<String> register(String email, String password) async {
    final url =
        Uri.parse('$baseUrl/auth/register'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'first_name': 'test',
        'last_name': 'test',
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['token'] != null) {
        return data['token'];
      } else {
        throw Exception("Token not found in the response");
      }
    } else {
      throw Exception("Invalid registration details: ${response.body}");
    }
  }

  @override
  Future<void> logout() async {
    // Assuming you need to call an API to log out
    final url = Uri.parse('$baseUrl/auth/logout');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // Handle successful logout, clear tokens, etc.
      return;
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }
}
