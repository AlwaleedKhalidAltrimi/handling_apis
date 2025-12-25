import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET('users')
  Future<List<UserModel>> getAllUsers();
}
