import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/auth_bloc/auth_event.dart';
import 'package:global_project/bloc/auth_bloc/auth_state.dart';
import 'package:global_project/service/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInButtonPressed>(_onSignInButtonPressed);
  }

  // Temporary storage for user credentials
  String _email = '';
  String _password = '';

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    _email = event.email;
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    _password = event.password;
  }

  Future<void> _onSignInButtonPressed(
      SignInButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isAuthenticated =
          await authService.signInWithEmailAndPassword(_email, _password);
      if (isAuthenticated == "Signed in") {
        emit(Authenticated());
      } else {
        emit(AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
