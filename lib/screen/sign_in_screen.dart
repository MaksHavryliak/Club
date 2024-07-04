import 'package:club/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Gay Club",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Form(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://patrioty.org.ua/images/2020/04/25122124_341838w540zc0_medium.jpg',
                    height: 250,
                    width: 950,
                  ),
                  const SizedBox(height: 15,),
                  //email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Enter your email"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                  const SizedBox(height: 15,),
                  //password
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Enter your password"),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    onFieldSubmitted: (_) {
                      //TODO: - Submit form
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
                  const SizedBox(height: 15,),
                  TextButton(onPressed: () {
                    //TODO: - Submit form
                  }, child: const Text("Sign In")),
                  TextButton(onPressed: () {
                    //TODO: Go to Sign up screen
                    Navigator.of(context).pushReplacementNamed(SignUpScreen.id);
                  }, child: const Text("Sign Up instead")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
