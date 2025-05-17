import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class Alerts {

  showAlert(context, bool success, String message){
    if(success){
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        titleText: Text(
          "Success",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
              fontFamily: "Sans"),
        ),
        messageText: Text(
          message,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: "Sans"),
        ),
      )..show(context);
    }else{
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        titleText: Text(
          "Error",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
                fontFamily: "Sans"),
        ),
        messageText: Text(
          message,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: "San"),
        ),
      )..show(context);
    }
  }
}