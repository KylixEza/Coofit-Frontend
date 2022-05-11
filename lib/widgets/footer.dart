import 'package:flutter/cupertino.dart';
import 'package:footer/footer.dart';

Footer buildCoofitFooter() {
  return Footer(
    child: Column(
      children: const [
        Text('Copyright ©2022, All Rights Reserved.'),
        SizedBox(height: 4),
        Text('Made by Kylix, Samuel, and Foresta with Flutter and Ktor')
      ],
    ),
  );
}