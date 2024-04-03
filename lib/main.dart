import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/auth_bloc.dart';
import 'package:global_project/bloc/transaction_bloc.dart';
import 'package:global_project/bloc/transaction_event.dart';
import 'package:global_project/bloc/transaction_state.dart';
import 'package:global_project/core/colorStyles_const.dart';
import 'package:global_project/core/textStyles_const.dart';
import 'package:global_project/screens/home_page.dart';
import 'package:global_project/screens/signIn_page.dart';
import 'package:global_project/service/TransactionAPIService.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(), // Initialize your AuthBloc
      child: MaterialApp(
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
