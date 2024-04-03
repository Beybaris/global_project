import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<void> signIn(String email, String password);
}

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
