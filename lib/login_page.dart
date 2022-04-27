import 'dart:io';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
        margin: const EdgeInsets.symmetric(vertical: 84 ),
        child: Card(
          elevation: 4,
          shadowColor: Colors.grey,
          child: Container(
            width: 720,
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children:  [
                Image.asset("images/main_logo.jpg", height: 128, width: 128),
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
                const SizedBox(height: 64),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}