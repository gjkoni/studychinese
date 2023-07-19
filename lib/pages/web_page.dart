import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studychinese/common/global.dart';
// import 'package:studychinese/common/str_res_keys.dart';
import 'package:studychinese/widgets/search_appbar.dart';

// ignore: must_be_immutable
class WebPage extends StatefulWidget {
  String url;
  WebPage({Key? key, required this.url}) : super(key: key);

  @override
  WebPageState createState() => WebPageState();
}

class WebPageState extends State<WebPage> {
  SharedPreferences sp = Global.preferences;
  final Completer<InAppWebViewController> completerController =
      Completer<InAppWebViewController>();

  InAppWebViewController? inAppController;
  RxBool err = false.obs;

  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     Global.logger.e('Couldn\'t check connectivity status:', e);
  //     return;
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) {
  //     return Future.value(null);
  //   }

  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     // _connectionStatus = result;
  //   });
  // }

  void checkPermisson() async {
    //当前权限
    Permission permission = Permission.camera;
    //权限的状态
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      // state.controller.future.then((controller) {

      // });
      inAppController?.evaluateJavascript(source: "window.setPStatus()");
    } else {
      requestPermiss(permission);
    }
  }

  void requestPermiss(Permission permission) async {
    //发起权限申请
    // PermissionStatus status = await permission.request();
    await permission.request();
    // 返回权限申请的状态 status
  }

  String setUrl(String text) {
    // return "http://pandaapi.smartpanda.com.cn/pad/index/$text?size=${ScreenUtil().screenWidth ~/ 3}&cover";
    return "http://localhost:8080/grnchinese/index.html?text=$text&size=${ScreenUtil().screenWidth / (text.length < 5 ? text.length : 5)}&cover";
    // return "http://localhost:8080/hanzi/index.html";
  }

  @override
  void initState() {
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: SearchAppBar(
          hintLabel: "输入想写的字",
          onSubmitted: (value) {
            widget.url = setUrl(value);
            inAppController?.loadUrl(
                urlRequest: URLRequest(url: WebUri(widget.url)));
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  gestureRecognizers: {
                    Factory(() => VerticalDragGestureRecognizer()),
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    debugPrint(consoleMessage.message);
                  },
                  onWebViewCreated: (controller) {},
                  onLoadStop: (controller, url) {
                    inAppController = controller;
                    // print("网页 onLoadStop--》");
                  },
                  onReceivedHttpError: ((controller, request, errorResponse) {
                    if (kDebugMode) {
                      print(request.url);
                      print(errorResponse);
                    }
                    err.value = true;
                  }),
                  onReceivedError: (controller, request, error) {
                    if (kDebugMode) {
                      print('bb  error');
                    }
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    // print("ServerTrust");
                    //解决 handshake failed问题
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                ),
                Obx(() => Visibility(
                    visible: err.value,
                    child: Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            err.value = false;
                            inAppController?.reload();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            child: const Center(
                              child: Text('网页错误'),
                            ),
                          ),
                        ))))
              ],
            )),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
