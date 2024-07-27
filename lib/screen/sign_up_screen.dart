import 'package:club/screen/posts_screen.dart';
import 'package:club/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_in_screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';

  late final FocusNode _passwordFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }
    _formKey.currentState!.save();

    context
        .read<AuthCubit>()
        .signUp(email: _email, username: _username, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            title: Text(
              "Gay Club",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            centerTitle: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://vgorode.ua/img/article/6108/27_main-v1584375899.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (prevState, currState) {
                if (currState is AuthSignedUp) {
                  Navigator.of(context).pushReplacementNamed(PostsScreen.id);
                }
                if (currState is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(currState.message)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            //username
                            TextFormField(
                              focusNode: _usernameFocusNode,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                labelText: "Enter your username",
                                prefixIcon: Icon(Icons.person),
                              ),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocusNode);
                              },
                              onSaved: (value) {
                                _username = value!.trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your username";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //email
                            TextFormField(
                              focusNode: _emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                labelText: "Enter your email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              onSaved: (value) {
                                _email = value!.trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //password
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0),
                                ),
                                labelText: "Enter your password",
                                prefixIcon: Icon(Icons.security),
                              ),
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              onFieldSubmitted: (_) {
                                _submit(context);
                              },
                              onSaved: (value) {
                                _password = value!.trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value.length < 5) {
                                  return "Please enter longer password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButton(
                                onPressed: () {
                                  _submit(context);
                                },
                                child: const Text("Sign Up")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(SignInScreen.id);
                                },
                                child: const Text("Sign In instead")),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}