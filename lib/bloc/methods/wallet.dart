import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart' show Response;
import 'package:doctor_app/utils/endpoints.dart';
import 'package:doctor_app/utils/http.dart';

import '../../models/response.dart';


Future<GResponse> performGetWalletBalance(payload) async {
  final Completer<bool> statusCompleter = Completer();
  Map<String, dynamic> extraData = <String, dynamic>{};
  String message = "";

  try {
    Response? response = await PSSAHttp.post('$WALLET',{
      "P_PERSON_ID" : payload
    });
    log("${response?.data.toString()}");
    if (((response?.statusCode ?? 200) >= 200 && (response?.statusCode ?? 200) <= 300)) {
      extraData = response?.data;
      // print(response?.data);
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