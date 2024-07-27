import 'dart:io';

import 'package:club/bloc/auth_cubit.dart';
import 'package:club/screen/create_post_screen.dart';
import 'package:club/screen/popular_clubs_screen.dart';
import 'package:club/screen/sign_in_screen.dart';
import 'package:club/screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PostsScreen extends StatefulWidget {
  static const String id = "posts_screen";

  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final picker = ImagePicker();
                picker
                    .pickImage(source: ImageSource.gallery, imageQuality: 40)
                    .then((xFile) {
                  if (xFile != null) {
                    final File file = File(xFile.path);

                    Navigator.of(context)
                        .pushNamed(CreatePostScreen.id, arguments: file);
                  }
                });
              },
              icon: const Icon(Icons.add)),
        ],
        title: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(PopularClubsScreen.id);
            },
            icon: const Icon(Icons.menu_book_sharp),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.read<AuthCubit>().signOut().then((_) =>
                Navigator.of(context).pushReplacementNamed(SignInScreen.id));
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
        return Container();
      }),
    );
  }
}
