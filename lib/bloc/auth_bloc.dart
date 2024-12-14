import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hearu/services/authentication/authentication_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService authenticationService;
  String? authToken; // Store the token

  AuthBloc(this.authenticationService) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogoutRequested);
    on<InitializeAuthEvent>(_onInitializeAuth);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token =
          await authenticationService.login(event.email, event.password);
      print(token);
      authToken = token; // Save the token
      // Save token in FlutterSecureStorage
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token =
          await authenticationService.register(event.email, event.password);
      authToken = token; // Store the token in the bloc
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authenticationService.logout();
      authToken = null; // Clear the token
      emit(AuthInitial());
    } catch (error) {
      emit(AuthFailure(message: error.toString()));
    }
  }

  Future<void> _onInitializeAuth(
      InitializeAuthEvent event, Emitter<AuthState> emit) async {
    authToken = event.token;
    emit(
        AuthSuccess()); // Emit success state since user is already authenticated
  }
}
