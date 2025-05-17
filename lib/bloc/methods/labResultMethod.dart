import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart' show Response;
import 'package:doctor_app/utils/endpoints.dart';
import 'package:doctor_app/utils/http.dart';

import '../../models/response.dart';


Future<GResponse> performGetLabResult(payload) async {
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.get('$LAB_RESULT/$payload');
    print(response?.statusCode);
    print(response?.statusMessage);
    if (((response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300)) {
      extraData = response?.data;
      print(response?.data);
    }
    else{
      extraData = response?.data;
      print(extraData);
    }

    statusCompleter.complete(
        (response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300
            ? true
            : false);
  } on KTimeoutException {
    statusCompleter.complete(false);
    message = 'Process timed out. Retry';
  } on Exception {

    statusCompleter.complete(false);
    message = 'Failed to get lab result';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}

Future<GResponse> performGetLabResultDetails(payload) async {
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.get('$LAB_RESULT_DETAILS/$payload');
    print(response?.statusCode);
    print(response?.statusMessage);
    if (((response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300)) {
      extraData = response?.data;
      print(response?.data);
    }
    else{
      extraData = response?.data;
      print(extraData);
    }

    statusCompleter.complete(
        (response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300
            ? true
            : false);
  } on KTimeoutException {
    statusCompleter.complete(false);
    message = 'Process timed out. Retry';
  } on Exception {

    statusCompleter.complete(false);
    message = 'Failed to get lab result';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}

Future<GResponse> performGetRadiologyResult(payload) async {
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.get('$RADIOLOGY_RESULT/$payload');
    print(response?.statusCode);
    print(response?.statusMessage);
    if (((response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300)) {
      extraData = response?.data;
      print(response?.data);
    }
    else{
      extraData = response?.data;
      print(extraData);
    }

    statusCompleter.complete(
        (response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300
            ? true
            : false);
  } on KTimeoutException {
    statusCompleter.complete(false);
    message = 'Process timed out. Retry';
  } on Exception {

    statusCompleter.complete(false);
    message = 'Failed to get lab result';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}
