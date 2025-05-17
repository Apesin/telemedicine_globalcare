import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart' show Response;
import 'package:doctor_app/utils/endpoints.dart';
import 'package:doctor_app/utils/http.dart';

import '../../models/response.dart';


Future<GResponse> performAuthenticateUser(payload) async {
  print(payload);
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.post('$AUTHENTICATION', payload);
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
    message = 'Failed to get badge';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}

Future<GResponse> performUserCardLogin(payload) async {
  print(payload);
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.get('$CARD_LOGIN/$payload',);
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
  } on KTimeoutException catch (e) {
    statusCompleter.complete(false);
    message = 'Process timed out. Retry';
    print('Timeout exception: $e');
  } catch (e, stackTrace) {
    statusCompleter.complete(false);
    message = 'Failed to register';
    print('Exception occurred: $e');
    print('Stack trace: $stackTrace');
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}


Future<GResponse> performCreateNewUser(payload) async {
  print(payload);
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.post('$CREATENEWUSER', payload);
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
  } catch(e){
    print(e);
    statusCompleter.complete(false);
    message = 'Failed to register';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}

Future<GResponse> performCreateExistingUser(payload) async {
  print(payload);
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.post('$CREATEEXISTINGUSER', payload);
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
  } catch(e){
    print(e);
    statusCompleter.complete(false);
    message =  'Failed to register';
  }

  final bool status = await statusCompleter.future;

  return GResponse(
    isSuccessful: status,
    errorMessage: message,
    extraData: extraData,
  );
}