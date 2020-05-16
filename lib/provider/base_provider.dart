import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseProvider with ChangeNotifier {
  static BuildContext context;

  void showMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  void performUnauthorize() {
    showMessage("UnAuthorized, Need to add new token!");
  }

  BaseProvider(BuildContext mContext) {
    context = mContext;
  }
}
