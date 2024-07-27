import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:club/bloc/auth_cubit.dart';
import 'package:club/repository/auth_repository.dart';
import 'package:club/firebase_options.dart';
import 'package:club/screen/create_post_screen.dart';
import 'package:club/screen/popular_clubs_screen.dart';
import 'package:club/screen/posts_screen.dart';
import 'package:club/screen/sign_in_screen.dart';
import 'package:club/screen/sign_up_screen.dart';

Future<void> main() async {
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
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepository()),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const SignUpScreen(),
        routes: {
          SignInScreen.id: (context) => const SignInScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          PostsScreen.id: (context) => const PostsScreen(),
          PopularClubsScreen.id: (context) => const PopularClubsScreen(),
          CreatePostScreen.id: (context) => const CreatePostScreen(),
        },
      ),
    );
  }
}