import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/login/login_body.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final CoofitRepository repository;

  LoginProvider({required this.repository});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  Future<void> login(LoginBody loginBody) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.getLoginInformation(loginBody);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        print(_message);
        notifyListeners();
      },
      (data) {
        if (data.isExist) {
          _isExist = true;
        } else {
          _isExist = false;
        }
        _state = RequestState.Success;
        notifyListeners();
      }
    );
  }
}