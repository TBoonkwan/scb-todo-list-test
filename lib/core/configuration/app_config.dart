import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String flavor = 'flavor';
  static String endpoint = 'endpoint';

  static String mockEnv = 'mock';
  static String prodEnv = 'prodEnv';
}

class AppConfig {
  static bool isMockEnv = dotenv.get(AppConstants.flavor).toString() ==
      AppConstants.mockEnv;

  static String getEnvironmentInstanceName() {
    if (isMockEnv) {
      return AppConstants.mockEnv;
    } else {
      return AppConstants.prodEnv;
    }
  }
}
