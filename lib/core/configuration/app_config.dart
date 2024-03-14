import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigConstants {
  static String flavor = 'flavor';
  static String endpoint = 'endpoint';

  static String mockEnv = 'mock';
  static String prodEnv = 'prodEnv';
}

class AppConfig {
  static bool isMockEnv =
      dotenv.get(ConfigConstants.flavor).toString() == ConfigConstants.mockEnv;

  static String getEnvironmentInstanceName() {
    if (isMockEnv) {
      return ConfigConstants.mockEnv;
    } else {
      return ConfigConstants.prodEnv;
    }
  }
}
