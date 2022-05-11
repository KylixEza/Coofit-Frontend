import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:flutter/material.dart';

class PredictionProvider extends ChangeNotifier {

  final CoofitRepository repository;

  PredictionProvider({required this.repository});

  RequestState _state = RequestState.Default;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  int _calories = 0;
  int get calories => _calories;

  String _food = '';
  String get food => _food;

  Future<void> getCaloriesPrediction(String food) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.getCaloriesPrediction(food);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _calories = data.calories;
        _food = data.food;
        _state = RequestState.Success;
        notifyListeners();
      }
    );
  }
}