import 'package:flutter/material.dart';
import '../style/style.dart';

BottomAppBar buildCoofitFooter() {
  return BottomAppBar(
    child: Container(
      height: 80,
      color: accentColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Copyright 2022 Kylix, Samuel, and Foresta. All rights reserved.", style: coofitTextTheme.caption),
          ],
        ),
      ),
    ),
  );
}