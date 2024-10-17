import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String getApiKey() {
    return dotenv.env['API_KEY'] ?? "";
  }
}
