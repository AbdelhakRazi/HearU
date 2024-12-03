import 'package:hearu/services/authentication/authentication_service.dart';

class SpringAuthService extends AuthenticationService {
  @override
  Future<void> login(String email, String password) async {
    // Mock login logic
    if (email == "test@example.com" && password == "Password123@") {
      return;
    }
    throw Exception("Invalid login credentials");
  }

  @override
  Future<void> register(String email, String password) async {
    // Mock register logic
    if (email.isNotEmpty && password.isNotEmpty) {
      return;
    }
    throw Exception("Invalid registration details");
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
