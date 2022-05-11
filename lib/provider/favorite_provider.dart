import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {

  final CoofitRepository repository;

  FavoriteProvider({required this.repository});

  RequestState _state = RequestState.Default;
  RequestState get state => _state;

  List<MenuLiteResponse> _menus = [];
  List<MenuLiteResponse> get menus => _menus;

  String _message = '';
  String get message => _message;

  Future<void> getFavorites() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.getFavorites();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        if(data.isEmpty) {
          _message = ' You have no any favorites :(';
          _state = RequestState.Empty;
          notifyListeners();
        } else {
          _menus = data;
          _state = RequestState.Success;
          notifyListeners();
        }
      }
    );
  }
}