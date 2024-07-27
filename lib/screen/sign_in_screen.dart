import 'package:club/bloc/auth_cubit.dart';
import 'package:club/screen/posts_screen.dart';
import 'package:club/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "sign_up_screen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }
    _formKey.currentState!.save();

    context.read<AuthCubit>().signIn(email: _email, password: _password);
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
                'https://patrioty.org.ua/images/2020/04/25122124_341838w540zc0_medium.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: BlocConsumer<AuthCubit, AuthState>(
                listener: (prevState, currentState) {
              if (currentState is AuthSignedIn) {
                Navigator.of(context).pushReplacementNamed(PostsScreen.id);
              }
              if (currentState is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(currentState.message)));
              }
            }, builder: (context, state) {
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
                          //email
                          TextFormField(
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
                            textInputAction: TextInputAction.next,
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
                              child: const Text("Sign In")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignUpScreen.id);
                              },
                              child: const Text("Sign Up instead")),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
