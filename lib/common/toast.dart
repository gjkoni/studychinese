// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void error(String msg, {Function? then}) {
    Fluttertoast.showToast(
            msg: msg,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white)
        .then((value) => then?.call());
  }

  static void info(String msg, {Function? then}) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER)
        .then((value) => then?.call());
  }
}
