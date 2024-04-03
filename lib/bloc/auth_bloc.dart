import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_project/bloc/auth_event.dart';
import 'package:global_project/bloc/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;

  AuthenticationBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_mapSignInRequestedToState);
  }

  Stream<AuthenticationState> _mapSignInRequestedToState(
      AuthenticationSignInRequested event,
      Emitter<AuthenticationState> emit) async* {
    yield AuthenticationLoading();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      yield AuthenticationAuthenticated();
    } catch (error) {
      yield AuthenticationFailure(error.toString());
    }
  }
}
