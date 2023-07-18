import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  //定义一个全局的 sp
  static late SharedPreferences preferences;
  static late Logger logger;

  //初始化
  static Future<SharedPreferences> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static initLogger() {
    logger = Logger();
    return logger;
  }
}
