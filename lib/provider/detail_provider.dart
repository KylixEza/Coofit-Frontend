import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/menu/menu_response.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {

  final CoofitRepository repository;

  DetailProvider({required this.repository});

  RequestState _state = RequestState.Default;
  RequestState get state => _state;

  late MenuResponse _menu;
  MenuResponse get menu => _menu;

  String _message = '';
  String get message => _message;

  Future<void> getMenuDetail(String menuId) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.getMenuDetail(menuId);
    result.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          _menu = data;
          _state = RequestState.Success;
          notifyListeners();
        }
    );
  }
}