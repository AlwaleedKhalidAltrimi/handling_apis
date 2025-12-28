import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  static Dio createAndSetupDio() {
    Dio dio = Dio();

    dio
      ..options.connectTimeout = 200 * 1000
      ..options.receiveTimeout = 200 * 1000;

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: true,
        requestBody: true,
      ),
    );

    return dio;
  }

  @GET('users')
  Future<List<UserModel>> getAllUsers();

  @GET("users/{id}")
  Future<UserModel> getUserById(@Path() String id);
}
