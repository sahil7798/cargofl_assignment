import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          flushbarPosition: FlushbarPosition.TOP,
          padding: EdgeInsets.all(15),
          forwardAnimationCurve: Curves.decelerate,
          message: message,
          reverseAnimationCurve: Curves.easeInOut,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          positionOffset: 20.0,
          borderRadius: BorderRadius.circular(10),
          icon: Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
        )..show(context));
  }
}
