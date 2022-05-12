import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/favorite/favorite_body.dart';
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

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

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

  void addNewFavorites(FavoriteBody body) async {
    final result = await repository.addNewFavorite(body);

    result.fold(
      (failure) {
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _message = data;
        _isFavorite = true;
        notifyListeners();
      }
    );
  }

  void deleteFavorite(FavoriteBody body) async {
    final result = await repository.deleteFavorite(body);

    result.fold(
      (failure) {
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _message = data;
        _isFavorite = false;
        notifyListeners();
      }
    );
  }
}