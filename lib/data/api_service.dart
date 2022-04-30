import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://localhost:8080/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;


}