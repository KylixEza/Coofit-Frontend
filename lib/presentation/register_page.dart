import 'package:coofit/presentation/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../style/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = "/register_page";

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {

  late TextEditingController _usernameController;
  String _username = "";

  late TextEditingController _passwordController;
  String _password = "";

  late TextEditingController _emailController;
  String _email = "";

  late TextEditingController _addressController;
  String address = "";

  late TextEditingController _phoneNumberController;
  String phoneNumber = "";

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
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)
          ),
          shadowColor: Colors.grey,
          child: Container(
            width: 720,
            padding: const EdgeInsets.all(32.0),
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
                const SizedBox(height: 32),
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
                const SizedBox(height: 14),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _username = text;
                    });
                  },
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                ),
                const SizedBox(height: 14),
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
                    text: "Register",
                    textStyle: coofitTextTheme.headline5?.merge(
                        const TextStyle(color: Colors.white)
                    )
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                      style: defaultStyle,
                      children: <TextSpan>[
                        const TextSpan(text: 'Have an account? '),
                        TextSpan(
                            text: 'Login',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context, LoginPage.routeName);
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