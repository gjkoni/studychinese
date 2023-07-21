import 'dart:async';
import 'dart:convert';

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
import 'package:studychinese/common/toast.dart';
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

  void addJavascriptHandler(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
        handlerName: 'closeView',
        callback: (args) {
          // print arguments coming from the JavaScript side!
          debugPrint(args.toString());
          Get.back(result: args[0]);
          // return data to the JavaScript side!
          // return {'bar': 'bar_value', 'baz': 'baz_value'};
          sp.remove("openurl");
        });
    controller.addJavaScriptHandler(
        handlerName: 'appToastInfo',
        callback: (args) {
          Toast.info(args[0]);
        });
    controller.addJavaScriptHandler(
        handlerName: 'appToastError',
        callback: (args) {
          // print arguments coming from the JavaScript side!
          Toast.error(args[0]);
        });
    controller.addJavaScriptHandler(
        handlerName: 'killoff', callback: (args) {});
    controller.addJavaScriptHandler(
        handlerName: 'getAppUAT', callback: (args) {});
    controller.addJavaScriptHandler(
        handlerName: "openFile",
        callback: (args) async {
          // var fileurl = args[0]["file"];
          // var title = args[0]["title"];
        });
    controller.addJavaScriptHandler(
        handlerName: 'openWebview',
        callback: (args) async {
          // var url = args[0]["url"];

          // if (sp.getString("openurl") == null ||
          //     sp.getString("openurl") != url) {
          //   sp.setString("openurl", url);

          // var returnData = await Get.to(page, preventDuplicates: false);
          // if (returnData != null) {
          //   sp.remove("openurl");
          //   var json = jsonEncode(returnData);
          //   // print(json);
          //   inAppController?.evaluateJavascript(source: 'setParams($json)');
          // }
          // }
        });
    controller.addJavaScriptHandler(
        handlerName: "getDeviceInfo",
        callback: (args) {
          // var data = {'statusBarHeight': ScreenUtil().statusBarHeight};
          // return data;
        });
    controller.addJavaScriptHandler(
        handlerName: 'routeApp',
        callback: (args) {
          // if (args[0]["router"].toString() == "product") {

          // }
        });
    controller.addJavaScriptHandler(
        handlerName: 'appAction',
        callback: (args) {
          if (args[0]["actionName"] == 'saveCharTestData') {
            var char = args[0]['params']['char'];
            var unicode = char.codeUnits[0].toRadixString(16);
            var key = 'char_$unicode';
            var listKey = 'list_$unicode';
            if (!sp.containsKey(key)) {
              sp.setInt(key, args[0]['params']['code']);
              sp.setStringList(listKey, [jsonEncode(args[0]['params'])]);
            } else {
              var keyCode = sp.getInt(key);
              if (keyCode != 1) {
                sp.setString(key, args[0]['params']['code']);
              }
              var list = sp.getStringList(listKey);
              list?.add(jsonEncode(args[0]['params']));
              sp.setStringList(listKey, list!);
            }
            var debugList = sp.getStringList(listKey);
            debugPrint(jsonEncode(debugList));
            debugPrint(args.toString());
            controller.evaluateJavascript(
                source:
                    'window.webAction("webAction", {"args": "${args.toString()}"})');
          }
        });
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
        actions: [
          GestureDetector(
            onTap: () => {inAppController?.reload()},
            child: Container(
              padding: const EdgeInsets.all(0),
              // decoration: const BoxDecoration(color: Colors.black),
              width: 60,
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  initialSettings: InAppWebViewSettings(
                    mediaPlaybackRequiresUserGesture: false,
                    useHybridComposition: true,
                    allowsInlineMediaPlayback: true,
                  ),
                  gestureRecognizers: {
                    Factory(() => VerticalDragGestureRecognizer()),
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    debugPrint(consoleMessage.message);
                  },
                  onWebViewCreated: (controller) {
                    addJavascriptHandler(controller);
                  },
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
