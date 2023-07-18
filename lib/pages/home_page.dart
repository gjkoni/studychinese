import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studychinese/common/toast.dart';
import 'package:studychinese/common/global.dart';
import 'package:studychinese/common/str_res_keys.dart';
import 'package:studychinese/constants/color_constant.dart';
import 'package:studychinese/constants/constant.dart';
import 'package:studychinese/controllers/http_server_controller.dart';
import 'package:studychinese/pages/settings_page.dart';
import 'package:studychinese/pages/words_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime? _lastPressedAt;
  int _currentPage = 0;
  final _selectedItemColor = ColorConstant.colorTheme;
  final _unselectedItemColor = ColorConstant.colorGray138;
  SharedPreferences sp = Global.preferences;
  late HttpServerController httpServerController;

  final List<Map> _pages = [
    {"key": "words", "page": const WordsPage()},
    {"key": "settings", "page": const SettingsPage()},
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: const Icon(
          IconData(0xe7e1, fontFamily: 'aliIcons'),
          color: ColorConstant.colorGray138,
        ),
        activeIcon: const Icon(
          IconData(0xe7e1, fontFamily: 'aliIcons'),
          color: ColorConstant.colorTheme,
        ),
        label: SR.words.tr),
    BottomNavigationBarItem(
        icon: const Icon(
          IconData(0xe78e, fontFamily: 'aliIcons'),
          color: ColorConstant.colorGray138,
        ),
        activeIcon: const Icon(
          IconData(0xe78e, fontFamily: 'aliIcons'),
          color: ColorConstant.colorTheme,
        ),
        label: SR.settings.tr),
  ];

  @override
  void initState() {
    httpServerController = Get.put(HttpServerController());
    SystemChrome.setSystemUIOverlayStyle(Constant.appUiOverlayStyle);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () async {
              if (_lastPressedAt == null ||
                  DateTime.now().difference(_lastPressedAt!) >
                      const Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressedAt = DateTime.now();
                Toast.info(SR.clickTwiceInSuccessionToExitTheApplication.tr);
                return false;
              }
              exit(0);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: IndexedStack(
                index: _currentPage,
                children: _pages.map((e) {
                  Widget w = e["page"] as Widget;
                  return w;
                }).toList(),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: _items,
              selectedItemColor: _selectedItemColor,
              unselectedItemColor: _unselectedItemColor,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              currentIndex: _currentPage,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                // _pageController.jumpToPage(index);
                setState(() {
                  _currentPage = index;
                  sp.setInt("home", _currentPage);
                });
              }),
        ),
      ],
    );
  }
}
