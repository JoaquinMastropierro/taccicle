import 'package:flutter/material.dart';

class ToastService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>(); 

  static error(String message){
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.6),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}