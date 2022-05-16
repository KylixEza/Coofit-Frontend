import 'package:coofit/common/state_enum.dart';
import 'package:coofit/provider/prediction_provider.dart';
import 'package:coofit/widgets/footer.dart';
import 'package:coofit/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../style/style.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  static const String routeName = '/prediction_page';

  @override
  State<StatefulWidget> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {

  final TextEditingController _predictionController = TextEditingController();
  String _foodName = '';

  late final SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
  }

  @override
  void dispose() {
    _predictionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar(context, 'Prediction'),
      bottomNavigationBar: buildCoofitFooter(),
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
        return Container(
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
                      onPressed: () => {
                        Provider.of<PredictionProvider>(context, listen: false)
                        .getCaloriesPrediction(_foodName)
                      },
                      color: primaryColor,
                      fullWidthButton: true,
                      text: "Predict",
                      textStyle: coofitTextTheme.headline5?.merge(
                          const TextStyle(color: Colors.white)
                      )
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Prediction Result',
                    style: coofitTextTheme.bodyText1,
                  ),
                  const SizedBox(height: 8),
                  _buildPredictResult()
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildPredictResult() {
    return Consumer<PredictionProvider>(
      builder: (context, value, child) {
        switch(value.state) {
          case RequestState.Loading: {
            return const CircularProgressIndicator();
          }
          case RequestState.Success: {
            return Text((value.calories > 0)
                ? '${value.food} memiliki kalori sebesar ${value.calories} kal'
                : 'Makanan yang kamu cari tidak dapat ditemukan :(',
            );
          }
          case RequestState.Default:
            return Container();
          case RequestState.Empty:
            return Container();
          case RequestState.Error:
            return Text(value.message);
        }
        return _buildPage();
      },
    );
  }
}