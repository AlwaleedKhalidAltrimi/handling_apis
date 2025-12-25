import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../cubit/user_cubit.dart';
import '../repo/user_repo.dart';
import '../services/api_services.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<UserCubit>(() => UserCubit(getIt()));
  getIt.registerLazySingleton<UserRepo>(() => UserRepo(getIt()));
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(createAndSetupDio()),
  );
}

Dio createAndSetupDio() {
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
