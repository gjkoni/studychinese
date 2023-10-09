import 'package:get/get.dart';
import 'package:studychinese/pages/home_page.dart';
import 'package:studychinese/pages/level_page.dart';
import 'package:studychinese/pages/settings_page.dart';
import 'package:studychinese/pages/words_page.dart';

class RouteGet {
  static const String home = "/home";
  static const String words = "/words";
  static const String settings = "/settings";
  static const String level = "/level";
  static const String web = "/web";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: words,
      page: () => const WordsPage(),
    ),
    GetPage(
      name: level,
      page: () => const LevelPage(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsPage(),
    ),
  ];
}
