import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig{
  static bool isMockEnv = dotenv.get("env").toString() == "mock";
}