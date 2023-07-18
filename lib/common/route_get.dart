import 'package:get/get.dart';
import 'package:studychinese/pages/settings_page.dart';
import 'package:studychinese/pages/words_page.dart';

class RouteGet {
  static const String words = "/words";
  static const String settings = "/settings";
  static const String web = "/web";

  static final List<GetPage> getPages = [
    GetPage(
      name: words,
      page: () => const WordsPage(),
      // bindings: [UserBinding(), AdminBinding(), HttpServerBinding()],
    ),
    GetPage(
      name: settings,
      page: () => const SettingsPage(),
    ),
  ];
}
