import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
import 'package:studychinese/study_chinese_app.dart';
// import 'package:studychinese/study_chinese_app.dart';

import 'common/global.dart';
// import 'pages/provider/provider_test1.dart';
// import 'pages/provider/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Global.initLogger();
  Global.initPreferences().then((value) {
    ErrorWidget.builder = (detail) => Container(
          alignment: Alignment.center,
          child: Text(detail.exceptionAsString()),
        );

    // runApp(Provider<UserModel>(
    //   create: (_) => UserModel(),
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: ProviderExample(),
    //   ),
    // ));

    runApp(const StudyChineseApp());

    if (Platform.isAndroid) {
      //设置android状态栏为透明
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ));
    }
  });
}
