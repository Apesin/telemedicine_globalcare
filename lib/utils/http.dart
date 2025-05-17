
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

import '../persistence/persistence.dart';
import '../persistence/strings.dart';
import 'endpoints.dart';




class PSSAHttp {
  static final int? timeout = 30000;
  static final Dio _dioClient = Dio(
      BaseOptions(
          baseUrl: BASE_URL
      )
  );

  static Future<Response?> post(String path, dynamic payload) async {
    var token = await getStringValuesSP(PrefStrings.TOKEN);
    print(path + "My Payload $payload");
    Response? response;
    if (payload.runtimeType == FormData) {
      _dioClient.options.contentType = "multipart/form-data";
    }
    try {
      response = await _dioClient.post(
        path,
        data: payload,
        options: Options(
          sendTimeout: Duration(seconds: timeout!),
          receiveTimeout: Duration(seconds: timeout! * 2),
          contentType: "application/json",
          headers: <String, dynamic>{
            "Accept" : "application/json",
            // "Authorization" : "Bearer $token"

          },
        ),
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse) {
        response = error.response;
      } else if ((error.type == DioErrorType.connectionTimeout) ||
          (error.type == DioErrorType.receiveTimeout) ||
          (error.type == DioErrorType.sendTimeout)) {
        throw KTimeoutException();
      } else {
        throw Exception();
      }
    }
    return response;
  }

  static Future<Response?> get(String path) async {
    var token = await getStringValuesSP(PrefStrings.TOKEN);
    print(path);
    Response? response;
    try {
      response = await _dioClient.get(
        path,
        options: Options(
          sendTimeout: Duration(seconds: timeout!),
          receiveTimeout: Duration(seconds: timeout! * 2),
          contentType: "application/json",
          headers: <String, dynamic>{
            // "Authorization": "Bearer $token ",
          },
        ),
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse) {
        response = error.response;
      } else if ((error.type == DioErrorType.connectionTimeout) ||
          (error.type == DioErrorType.receiveTimeout) ||
          (error.type == DioErrorType.sendTimeout)) {
        throw KTimeoutException();
      } else {
        throw Exception();
      }
    }
    return response;
  }


  static Future<Response?> delete(String path) async {
    var token = await getStringValuesSP(PrefStrings.TOKEN);

    Response? response;
    try {
      response = await _dioClient.delete(
        path,
        options: Options(
          sendTimeout: Duration(seconds: timeout!),
          receiveTimeout: Duration(seconds: timeout! * 2),
          contentType: "application/json",
          headers: <String, dynamic>{
            // "Authorization": "Bearer $token ",
          },
        ),
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse) {
        response = error.response;
      } else if ((error.type == DioErrorType.connectionTimeout) ||
          (error.type == DioErrorType.receiveTimeout) ||
          (error.type == DioErrorType.sendTimeout)) {
        throw KTimeoutException();
      } else {
        throw Exception();
      }
    }
    return response;
  }

  static Future<Response?> patch(String path, dynamic payload) async {
    var token = await getStringValuesSP(PrefStrings.TOKEN);
    Response? response;
    if (payload.runtimeType == FormData) {
      _dioClient.options.contentType = "multipart/form-data";
    }
    try {
      response = await _dioClient.patch(
        path,
        data: payload,
        options: Options(
          sendTimeout: Duration(seconds: timeout!),
          receiveTimeout: Duration(seconds: timeout! * 2),
          contentType: "application/json",
          headers: <String, dynamic>{
            "Authorization": "Bearer $token",
          },
        ),
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse) {
        response = error.response;
      } else if ((error.type == DioErrorType.connectionTimeout) ||
          (error.type == DioErrorType.receiveTimeout) ||
          (error.type == DioErrorType.sendTimeout)) {
        throw KTimeoutException();
      } else {
        throw Exception();
      }
    }
    return response;
  }


}



class KTimeoutException implements Exception {
  KTimeoutException();
}
