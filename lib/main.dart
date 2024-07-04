import 'package:club/screen/sign_in_screen.dart';
import 'package:club/screen/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home:  const SignUpScreen(),
      routes: {
        SignInScreen.id : (context) => const SignInScreen(),
        SignUpScreen.id : (context) => const SignUpScreen(),
      },
    );
  }
}


