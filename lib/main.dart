import 'package:coofit/presentation/login_page.dart';
import 'package:coofit/presentation/register_page.dart';
import 'package:coofit/style/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coofit',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: coofitTextTheme,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage()
      },
      home: const LoginPage(),
    );
  }
}