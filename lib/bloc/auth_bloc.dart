import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hearu/services/authentication/authentication_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService authenticationService;
  String? _authToken; // Store the token

  AuthBloc(this.authenticationService) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogoutRequested);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token =
          await authenticationService.login(event.email, event.password);
      print(token);
      _authToken = token; // Save the token
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
      _authToken = token; // Store the token in the bloc
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
      _authToken = null; // Clear the token
      emit(AuthInitial());
    } catch (error) {
      emit(AuthFailure(message: error.toString()));
    }
  }
}
