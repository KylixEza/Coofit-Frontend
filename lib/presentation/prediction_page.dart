import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../style/style.dart';
import 'home_page.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  static const String routeName = '/prediction_page';

  @override
  State<StatefulWidget> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {

  late TextEditingController _predictionController;
  String _foodName = '';

  @override
  void initState() {
    _predictionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _predictionController.dispose();
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
            height: 420,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("images/main_logo.jpg", height: 80, width: 80),
                const SizedBox(height: 16.0),
                const Text(
                  "Calories Prediction",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "poppins",
                      fontSize: 36,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _predictionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Food's Name",
                  ),
                  onChanged: (text) {
                    setState(() {
                      _foodName = text;
                    });
                  },
                ),
                const SizedBox(height: 14),
                GFButton(
                    onPressed: () {

                    },
                    color: primaryColor,
                    fullWidthButton: true,
                    text: "Predict",
                    textStyle: coofitTextTheme.headline5?.merge(
                        const TextStyle(color: Colors.white)
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}