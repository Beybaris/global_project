import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:global_project/bloc/auth_bloc.dart';
import 'package:global_project/firebase_options.dart';
import 'package:global_project/screens/home_page.dart';
import 'package:global_project/screens/signIn_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => BlocProvider(
              create: (context) =>
                  AuthenticationBloc(firebaseAuth: _firebaseAuth),
              child: SignInPage(),
            ),
        '/home': (context) => BlocProvider(
              create: (context) =>
                  AuthenticationBloc(firebaseAuth: _firebaseAuth),
              child: HomePage(),
            ),
      },
    );
  }
}
