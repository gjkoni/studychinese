import 'dart:async';
//import 'dart:convert';
import 'dart:io';
// import 'package:archive/archive_io.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:mime/mime.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:studychinese/common/toast.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart';
import 'package:studychinese/common/toast.dart';

class HttpServerController extends GetxController {
  // HttpServer? server;
  // Directory directory = Directory("/storage/emulated/0");
  double progress = 0.0;

  @override
  void onInit() {
    debugPrint('启动服务器');
    EasyLoading.init();
    startShelfServer();
    super.onInit();
  }

  Future<shelf.Handler> get handler async {
    final router = shelf_router.Router();

    var documentDirectory = await getApplicationDocumentsDirectory();
    String folderPath = documentDirectory.path;
    debugPrint(folderPath);
    var root = '$folderPath/wwwroot';

    const zipfile = 'https://cdn.smartmicky.com/static/zip/grnchinese.zip';
    const zipname = 'grnchinese';
    var path = '$root/$zipname';
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      // path = await copyAssets();
      await downFile(zipfile, zipname, root);
    }

    var staticHandler =
        createStaticHandler(path, defaultDocument: 'index.html');

    // Other routers can be mounted...
    router.mount('/$zipname/', staticHandler);

    router.all('/<ignored|.*>', (shelf.Request request) {
      return shelf.Response.notFound('Page not found');
    });

    return router;
  }

  // static Future<String> copyAssets() async {
  //   EasyLoading.show(maskType: EasyLoadingMaskType.black);
  //   int now = DateTime.now().millisecondsSinceEpoch;

  //   var documentDirectory = await getApplicationDocumentsDirectory();
  //   String folderPath = documentDirectory.path;
  //   final manifestContent = await rootBundle.loadString('AssetManifest.json');
  //   final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  //   final assetList = manifestMap.keys
  //       .where((String key) => key.startsWith('wwwroot'))
  //       .toList();

  //   for (final asset in assetList) {
  //     if (!asset.contains('.DS_Store')) {
  //       await copyAsset(asset, folderPath);
  //     }
  //   }
  //   EasyLoading.dismiss();

  //   debugPrint('移动文件耗时 = ${DateTime.now().millisecondsSinceEpoch - now}毫秒');
  //   return '$folderPath/wwwroot';
  // }

  // static Future<File> copyAsset(String assetName, String localPath) async {
  //   int lastSeparatorIndex = assetName.lastIndexOf('/');
  //   Directory directory = Directory(
  //       '$localPath${Platform.pathSeparator}${assetName.substring(0, lastSeparatorIndex)}');

  //   if (!directory.existsSync()) directory.createSync(recursive: true);
  //   ByteData data = await rootBundle.load(assetName);
  //   Uint8List bytes = data.buffer.asUint8List();

  //   final file = File('$localPath${Platform.pathSeparator}$assetName');
  //   await file.writeAsBytes(bytes);
  //   return file;
  // }

  Future<void> startShelfServer() async {
    final server = await io.serve(await handler, 'localhost', 8080);
    debugPrint('Server running on localhost:${server.port}');
  }

  // Future<void> startServer() async {
  //   server?.close();
  //   server = await HttpServer.bind(InternetAddress.anyIPv4, 12321);
  //   await server?.forEach((HttpRequest request) async {
  //     debugPrint(request.uri as String?);
  //     // Directory directory = Directory("/storage/emulated/0/panda");
  //     // Directory directory = Directory(
  //     //     "${(await getExternalStorageDirectory())!.path}/${logic.state.modelName.value}");
  //     String filePath = 'assets/htmls/hanzi/index.html';
  //     String html = await rootBundle.loadString(filePath);
  //     var mime = lookupMimeType(filePath) ?? "*/*";

  //     try {
  //       try {
  //         request.response
  //           ..statusCode = 200
  //           ..headers.set("Content-Type", mime)
  //           ..write(html)
  //           ..close();
  //       } catch (exception) {
  //         debugPrint('Error happened: $exception');
  //       }
  //     } catch (e) {
  //       e.printError();
  //     }
  //   });
  // }

  Future<bool> downFile(url, name, root) async {
    EasyLoading.showProgress(progress,
        status: '初始加载资源 ${(progress * 100).toStringAsFixed(0)}%',
        maskType: EasyLoadingMaskType.black);
    debugPrint('url:$url name:$name');
    var saveFile = File("$root/$name.zip");
    bool isDownSuccess = false;
    var startTime = DateTime.now();
    if (saveFile.existsSync()) {
      debugPrint('文件已存在');
      isDownSuccess = true;
    } else {
      Directory rootDir = Directory(root);
      if (!rootDir.existsSync()) {
        rootDir.createSync();
      }
      saveFile.createSync();

      debugPrint('下载文件url:$url');
      try {
        await Dio().download(url, saveFile.path,
            onReceiveProgress: (int count, int total) {
          debugPrint('下载进度count:$count total:$total');
          progress = count / total;
          EasyLoading.showProgress(progress,
              status: '初始加载资源 ${(progress * 100).toStringAsFixed(0)}%',
              maskType: EasyLoadingMaskType.black);
        });
        isDownSuccess = true;
      } catch (e) {
        e.printError();
        debugPrint('下载文件url:$url异常：$e');
        saveFile.deleteSync();
        EasyLoading.dismiss();
      }
    }
    var endTime = DateTime.now();
    var t = endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;
    if (isDownSuccess) {
      debugPrint("下载解压时间$t");
      debugPrint('下载文件url:$url成功');
      await unZip(saveFile, '$root/$name');
      debugPrint('解压文件成功');
    } else {
      debugPrint('下载文件url:$url失败');
      Toast.error("下载失败");
      EasyLoading.dismiss();
    }
    return isDownSuccess;
  }

  unZip(file, unzipName) async {
    EasyLoading.dismiss();
    EasyLoading.showInfo('正在解压资源中...', maskType: EasyLoadingMaskType.black);
    await extractFileToDisk(file.path, unzipName);
    EasyLoading.dismiss();
  }

  @override
  void onClose() {
    debugPrint('关闭服务器');
  }
}
