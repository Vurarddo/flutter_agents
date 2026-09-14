import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/infrastructure/config/app_config.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        requestBody: AppConfig.isDev,
        responseBody: AppConfig.isDev,
      ),
    );
    return dio;
  }
}
