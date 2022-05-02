import 'package:flutter/cupertino.dart';

import '../common/state_enum.dart';
import '../data/coofit_repository_impl.dart';
import '../model/user/user_body.dart';

class RegisterProvider extends ChangeNotifier {
  final CoofitRepository repository;

  RegisterProvider({required this.repository});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> addNewUser(UserBody body) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await repository.addNewUser(body);
    result.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          _message = data;
          _state = RequestState.Success;
          notifyListeners();
        }
    );
  }
}