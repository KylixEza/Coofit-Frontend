import 'dart:io';

import 'package:coofit/presentation/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../style/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = "/login_page";

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _usernameController;
  String _username = "";

  late TextEditingController _passwordController;
  String _password = "";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 32.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
          ),
          shadowColor: Colors.grey,
          child: Container(
            width: 720,
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children:  [
                Image.asset("images/main_logo.jpg", height: 80, width: 80),
                const SizedBox(height: 16),
                const Text(
                  "Coofit",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "poppins",
                    fontSize: 42,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _username = text;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                ),
                const SizedBox(height: 14),
                GFButton(
                  onPressed: () {

                  },
                  color: primaryColor,
                  fullWidthButton: true,
                  text: "Login",
                  textStyle: coofitTextTheme.headline5?.merge(
                    const TextStyle(color: Colors.white)
                  )
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    style: defaultStyle,
                    children: <TextSpan>[
                      const TextSpan(text: 'Do not have any account? '),
                      TextSpan(
                        text: 'Register',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, RegisterPage.routeName);
                          }
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}