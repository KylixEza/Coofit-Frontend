import 'package:coofit/model/base_list_response.dart';
import 'package:coofit/model/login/login_body.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:coofit/model/menu/menu_response.dart';
import 'package:coofit/model/prediction/prediction_response.dart';
import 'package:coofit/model/user/user_body.dart';
import 'package:coofit/model/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/base_response.dart';
import '../model/favorite/favorite_body.dart';
import '../model/login/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api-pemweb-coofit-v2.herokuapp.com/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST("user")
  Future<BaseResponse<String>> addNewUser(@Body() UserBody body);

  @POST("user/login")
  Future<BaseResponse<LoginResponse>> getLoginInformation(
    @Body() LoginBody body);

  @GET("user/{uid}")
  Future<BaseResponse<UserResponse>> getUserDetail(@Path("uid") String uid);

  @PUT("user/{uid}")
  Future<BaseResponse<String>> updateUser(@Path("uid") String uid, @Body() UserBody body);

  @POST("user/{uid}/favorite")
  Future<BaseResponse<String>> addNewFavorite(@Path("uid") uid, @Body() FavoriteBody body);

  @DELETE("user/{uid}/favorite")
  Future<BaseResponse<String>> deleteFavorite(@Path("uid") uid, @Body() FavoriteBody body);

  @GET("user/{uid}/favorite")
  Future<BaseListResponse<List<MenuLiteResponse>>> getFavorites(@Path("uid") String uid);

  @GET("menu/top")
  Future<BaseListResponse<List<MenuLiteResponse>>> getTopMenus();

  @GET("menu")
  Future<BaseListResponse<List<MenuLiteResponse>>> searchMenus(@Query("query") String query);

  @GET("menu/{menuId}")
  Future<BaseResponse<MenuResponse>> getMenuDetail(@Path("menuId") String menuId);

  @GET("menu/prediction")
  Future<BaseResponse<PredictionResponse>> getCaloriesPrediction(@Query("food") String food);
}