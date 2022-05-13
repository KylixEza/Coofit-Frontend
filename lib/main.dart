import 'package:coofit/presentation/detail_page.dart';
import 'package:coofit/presentation/favorite_page.dart';
import 'package:coofit/presentation/home_page.dart';
import 'package:coofit/presentation/login_page.dart';
import 'package:coofit/presentation/prediction_page.dart';
import 'package:coofit/presentation/profile_page.dart';
import 'package:coofit/presentation/register_page.dart';
import 'package:coofit/provider/detail_provider.dart';
import 'package:coofit/provider/favorite_provider.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/provider/login_provider.dart';
import 'package:coofit/provider/prediction_provider.dart';
import 'package:coofit/provider/profile_provider.dart';
import 'package:coofit/provider/register_provider.dart';
import 'package:coofit/style/style.dart';
import 'package:coofit/utils/route_observer.dart';
import 'package:flutter/cupertino.dart';
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
        ChangeNotifierProvider(create: (_) => di.locator<DetailProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<PredictionProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<RegisterProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<FavoriteProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<ProfileProvider>()),
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
        home: const LoginPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch(settings.name) {
            case HomePage.routeName:
              return CupertinoPageRoute(builder: (_) => const HomePage(), settings: settings);
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (_) => const LoginPage(), settings: settings);
            case RegisterPage.routeName:
              return MaterialPageRoute(builder: (_) => const RegisterPage(), settings: settings);
            case DetailPage.routeName:
              final menuId = settings.arguments as String;
              return MaterialPageRoute(builder: (_) => DetailPage(menuId: menuId), settings: settings);
            case PredictionPage.routeName:
              return MaterialPageRoute(builder: (_) => const PredictionPage(), settings: settings);
            case FavoritePage.routeName:
              return MaterialPageRoute(builder: (_) => const FavoritePage(), settings: settings);
            case ProfilePage.route_name:
              return MaterialPageRoute(builder: (_) => const ProfilePage(), settings: settings);
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              }, settings: settings);
          }
        },
      ),
    );
  }
}