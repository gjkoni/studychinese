import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/global.dart';
import 'common/route_get.dart';
import 'common/string_res.dart';
// import 'pages/home_page.dart';

class StudyChineseApp extends StatefulWidget {
  const StudyChineseApp({super.key});

  @override
  StudyChineseAppState createState() => StudyChineseAppState();
}

class StudyChineseAppState extends State<StudyChineseApp>
    with WidgetsBindingObserver {
  final initLocal = const Locale('zh', 'CN');
  SharedPreferences sp = Global.preferences;
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    var language = sp.getString("language");
    var country = sp.getString("country");

    Locale? localeSetting;
    if (language != null && country != null) {
      localeSetting = Locale(language, country);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var locale = localeSetting ?? initLocal;
      setState(() {
        Get.updateLocale(locale);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _linkSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this); //销毁
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        ensureScreenSize: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteGet.home,
            title: '学写字',
            builder: EasyLoading.init(),
            getPages: RouteGet.getPages,
            locale: View.of(context).platformDispatcher.locale,
            translations: StringRes(),
            fallbackLocale: initLocal,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        });
  }
}
