import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studychinese/db/db_manager.dart';

class Global {
  //定义一个全局的 sp
  static late SharedPreferences preferences;
  static late Logger logger;
  static late DBManager db;

  //初始化
  static Future<SharedPreferences> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static initLogger() {
    logger = Logger();
    return logger;
  }

  static initDB() {
    db = DBManager();
    return db;
  }
}
