import 'package:bloc/bloc.dart';
import 'package:global_project/bloc/auth_event.dart';
import 'package:global_project/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInButtonPressed) {
      yield AuthLoading();
      try {
        // Simulate sign-in process (replace with your actual sign-in logic)
        await Future.delayed(Duration(seconds: 2));
        yield Authenticated();
      } catch (e) {
        yield AuthError('Failed to sign in: $e');
      }
    }
  }
}
