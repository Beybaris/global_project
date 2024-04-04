import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/auth_bloc/auth_bloc.dart';
import 'package:global_project/screens/home_page.dart';
import 'package:global_project/screens/signIn_page.dart';
import 'package:global_project/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authService: context.read<AuthService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/signin', // Set the initial route
        routes: {
          '/signin': (context) => SignInPage(), // Define the SignInPage route
          '/home': (context) => HomePage(), // Define the HomePage route
          // Add more routes if needed
        },
      ),
    );
  }
}
