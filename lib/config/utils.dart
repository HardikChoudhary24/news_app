import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }

  static Future<bool> deviceConnectedToInternet() async {
    final Connectivity _connectivity = Connectivity();

    List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    return true;
  }
}
