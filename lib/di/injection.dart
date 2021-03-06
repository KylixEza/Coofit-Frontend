import 'package:coofit/data/coofit_repository_impl.dart';
import 'package:coofit/data/preference_helper.dart';
import 'package:coofit/provider/detail_provider.dart';
import 'package:coofit/provider/favorite_provider.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/provider/login_provider.dart';
import 'package:coofit/provider/prediction_provider.dart';
import 'package:coofit/provider/profile_provider.dart';
import 'package:coofit/provider/register_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api_service.dart';

final locator = GetIt.instance;

void initInjection() {
  _dataSourcesLocator();
  _repositoryLocator();
  _providerLocator();
}

void _providerLocator() {
  locator.registerFactory(
    () => LoginProvider(repository: locator())
  );
  locator.registerFactory(
    () => RegisterProvider(repository: locator())
  );
  locator.registerFactory(
    () => HomeProvider(repository: locator())
  );
  locator.registerFactory(
    () => DetailProvider(repository: locator())
  );
  locator.registerFactory(
    () => PredictionProvider(repository: locator())
  );
  locator.registerFactory(
    () => FavoriteProvider(repository: locator())
  );
  locator.registerFactory(
    () => ProfileProvider(repository: locator())
  );
}

void _dataSourcesLocator() {
  locator.registerLazySingleton(
          () => ApiService(Dio(BaseOptions(contentType: "application/json"))));
  locator.registerLazySingleton(
          () => PreferenceHelper(sharedPreference: SharedPreferences.getInstance()));
}

void _repositoryLocator() {
  locator.registerLazySingleton<CoofitRepository>(
          () => CoofitRepositoryImpl(apiService: locator(), preference: locator()));
}