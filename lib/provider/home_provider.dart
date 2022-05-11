import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:flutter/material.dart';

import '../common/state_enum.dart';

class HomeProvider extends ChangeNotifier {
  final CoofitRepository repository;

  HomeProvider({required this.repository}) {
    getTopMenus();
  }

  RequestState _state = RequestState.Default;
  RequestState get state => _state;

  List<MenuLiteResponse> _menus = [];
  List<MenuLiteResponse> get menus => _menus;

  String _message = '';
  String get message => _message;

  Future<dynamic> getTopMenus() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.getTopMenus();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _message = "Tidak ada menu yang dapat ditampilkan :(";
          _state = RequestState.Empty;
        } else {
          _menus = data;
          print(data);
          _state = RequestState.Success;
        }
        notifyListeners();
      }
    );
  }

  Future<void> searchMenu(String q) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.searchMenus(q);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _menus = data;
        _state = RequestState.Success;
        notifyListeners();
      }
    );
  }
}