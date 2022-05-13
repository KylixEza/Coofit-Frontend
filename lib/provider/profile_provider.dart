import 'package:coofit/common/state_enum.dart';
import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/model/user/user_body.dart';
import 'package:coofit/model/user/user_response.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {

  final CoofitRepository repository;

  ProfileProvider({required this.repository});

  RequestState _state = RequestState.Default;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  late UserResponse _user;
  UserResponse get user => _user;

  Future<void> getUserDetail() async {
    _state = RequestState.Loading;
    notifyListeners();

    final response = await repository.getUserDetail();

    response.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _user = data;
        _state = RequestState.Success;
        notifyListeners();
      }
    );
  }

  Future<void> updateUser(UserBody body) async {
    _state = RequestState.Loading;
    notifyListeners();

    final response = await repository.updateUser(body);

    response.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _user = data;
        _state = RequestState.Success;
        notifyListeners();
      }
    );
  }
}