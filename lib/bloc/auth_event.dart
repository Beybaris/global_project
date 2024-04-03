abstract class AuthEvent {}

class SignInButtonPressed extends AuthEvent {}

class EmailChanged extends AuthEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged({required this.password});
}
