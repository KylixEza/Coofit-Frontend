import 'dart:js';

import 'package:coofit/presentation/home_page.dart';
import 'package:flutter/material.dart';

import '../presentation/favorite_page.dart';
import '../presentation/prediction_page.dart';
import '../presentation/profile_page.dart';
import '../style/style.dart';

AppBar buildNavBar(BuildContext context, String position) {

  final selectedTextStyle = Text(
      position,
      style: coofitTextTheme.caption?.merge(const TextStyle(fontWeight: FontWeight.bold))
  );

  return AppBar(
    backgroundColor: primaryColor,
    leading: Container(),
    title: Text('Coofit'),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const SizedBox(width: 16),
            InkWell(
              child: (position == 'Home')
                ? selectedTextStyle
                : const Text('Home'),
              onTap: () => Navigator.pushNamed(context, HomePage.routeName),
            ),
            const SizedBox(width: 16),
            InkWell(
              child: (position == 'Prediction')
                  ? selectedTextStyle
                  : const Text('Prediction'),
              onTap: () => Navigator.pushNamed(context, PredictionPage.routeName),
            ),
            const SizedBox(width: 16),
            InkWell(
              child: (position == 'Favorite')
                  ? selectedTextStyle
                  : const Text('Favorite'),
              onTap: () => Navigator.pushNamed(context, FavoritePage.routeName),
            ),
            const SizedBox(width: 16),
            InkWell(
              child: (position == 'Profile')
                  ? selectedTextStyle
                  : const Text('Profile'),
              onTap: () => Navigator.pushNamed(context, ProfilePage.route_name),
            ),
            SizedBox(width: 16),
          ],
        ),
      )
    ],
  );
}