import 'package:coofit/data/api_service.dart';
import 'package:coofit/data/preference_helper.dart';
import 'package:coofit/model/favorite/favorite_body.dart';
import 'package:coofit/model/login/login_body.dart';
import 'package:coofit/model/login/login_response.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:coofit/model/menu/menu_response.dart';
import 'package:coofit/model/prediction/prediction_response.dart';
import 'package:coofit/model/user/user_body.dart';
import 'package:coofit/model/user/user_response.dart';
import 'package:dartz/dartz.dart';

import '../common/failure.dart';

abstract class CoofitRepository {
  Future<Either<Failure, String>> addNewUser(UserBody body);
  Future<Either<Failure, LoginResponse>> getLoginInformation(LoginBody body);
  void logout();
  Future<Either<Failure, UserResponse>> getUserDetail();
  Future<Either<Failure, String>> updateUser(UserBody body);
  Future<Either<Failure, String>> addNewFavorite(FavoriteBody body);
  Future<Either<Failure, String>> deleteFavorite(FavoriteBody body);
  Future<Either<Failure, List<MenuLiteResponse>>> getFavorites();
  Future<Either<Failure, List<MenuLiteResponse>>> getTopMenus();
  Future<Either<Failure, List<MenuLiteResponse>>> searchMenus(String query);
  Future<Either<Failure, MenuResponse>> getMenuDetail(String menuId);
  Future<Either<Failure, PredictionResponse>> getCaloriesPrediction(String food);
}

class CoofitRepositoryImpl extends CoofitRepository {

  final ApiService apiService;
  final PreferenceHelper preference;

  CoofitRepositoryImpl({
    required this.apiService,
    required this.preference,
  });

  @override
  Future<Either<Failure, String>> addNewUser(UserBody body) async {
    try {
      final response = await apiService.addNewUser(body);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> getLoginInformation(LoginBody body) async {
    try {
      final response = await apiService.getLoginInformation(body);
      if (response.status == "200") {
        final data = response.data;
        preference.setUid(data.uid);
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void logout() {
    preference.removeUid();
  }

  @override
  Future<Either<Failure, UserResponse>> getUserDetail() async {
    try {
      final uid = await preference.getUid();
      final response = await apiService.getUserDetail(uid);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateUser(UserBody body) async {
    try {
      final uid = await preference.getUid();
      final response = await apiService.updateUser(uid, body);
      if (response.status == "200")  {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addNewFavorite(FavoriteBody body) async {
    try {
      final uid = await preference.getUid();
      final response = await apiService.addNewFavorite(uid, body);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFavorite(FavoriteBody body) async {
    try {
      final uid = await preference.getUid();
      final response = await apiService.deleteFavorite(uid, body);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuLiteResponse>>> getFavorites() async {
    try {
      final uid = await preference.getUid();
      final response = await apiService.getFavorites(uid);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch(e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuLiteResponse>>> getTopMenus() async {
    try {
      final response = await apiService.getTopMenus();
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuLiteResponse>>> searchMenus(String query) async {
    try {
      final response = await apiService.searchMenus(query);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MenuResponse>> getMenuDetail(String menuId) async {
    try {
      final response = await apiService.getMenuDetail(menuId);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PredictionResponse>> getCaloriesPrediction(String food) async {
    try {
      final response = await apiService.getCaloriesPrediction(food);
      if (response.status == "200") {
        final data = response.data;
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}