import 'package:coofit/presentation/detail_page.dart';
import 'package:coofit/presentation/home_page.dart';
import 'package:coofit/presentation/login_page.dart';
import 'package:coofit/presentation/prediction_page.dart';
import 'package:coofit/presentation/register_page.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/provider/login_provider.dart';
import 'package:coofit/style/style.dart';
import 'package:flutter/material.dart';
import 'package:coofit/di/injection.dart' as di;
import 'package:provider/provider.dart';

void main() {
  di.initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<HomeProvider>()),
      ],
      child: MaterialApp(
        title: 'Coofit',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: coofitTextTheme,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => const DetailPage(),
          PredictionPage.routeName: (context) => const PredictionPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}