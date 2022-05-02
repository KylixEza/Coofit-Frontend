import 'package:coofit/data/api_service.dart';
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
  Future<Either<Failure, UserResponse>> getUserDetail(String uid);
  Future<Either<Failure, String>> updateUser(String uid, UserBody body);
  Future<Either<Failure, String>> addNewFavorite(String uid, FavoriteBody body);
  Future<Either<Failure, String>> deleteFavorite(String uid, FavoriteBody body);
  Future<Either<Failure, List<MenuLiteResponse>>> getFavorites(String uid);
  Future<Either<Failure, List<MenuLiteResponse>>> getTopMenus();
  Future<Either<Failure, List<MenuLiteResponse>>> searchMenus(String query);
  Future<Either<Failure, MenuResponse>> getMenuDetail(String menuId);
  Future<Either<Failure, PredictionResponse>> getCaloriesPrediction(String food);
}

class CoofitRepositoryImpl extends CoofitRepository {

  final ApiService apiService;

  CoofitRepositoryImpl({
    required this.apiService
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
        return Right(data);
      } else {
        throw ServerFailure(response.message);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserResponse>> getUserDetail(String uid) async {
    try {
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
  Future<Either<Failure, String>> updateUser(String uid, UserBody body) async {
    try {
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
  Future<Either<Failure, String>> addNewFavorite(String uid, FavoriteBody body) async {
    try {
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
  Future<Either<Failure, String>> deleteFavorite(String uid, FavoriteBody body) async {
    try {
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
  Future<Either<Failure, List<MenuLiteResponse>>> getFavorites(String uid) async {
    try {
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