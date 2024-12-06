abstract class AuthenticationService {
  Future<String> login(String email, String password);
  Future<String> register(String email, String password);
  Future<void> logout();
}
