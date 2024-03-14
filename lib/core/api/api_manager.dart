import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scb_test/core/configuration/app_config.dart';

class ApiManager {
  Dio initial() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.env[ConfigConstants.endpoint].toString(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final dio = Dio(options)
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    return dio;
  }
}
