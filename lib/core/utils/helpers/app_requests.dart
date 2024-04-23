import 'dart:convert';
import 'dart:developer';

import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom/app_snackbar.dart';
import 'storage_helper.dart';

class AppRequest {
  static Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      var token = StorageHelper.getAccessToken();

      print("---------------$token");

      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      print("---------------$token");

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      LogHelper.info("Post Request Header ==> $url",
          error: json.encode(headers));
      LogHelper.info("Post Request Payload ==> $url", error: json.encode(body));
      LogHelper.info("Post Request Response ==> $url", error: response.body);

      if (response.statusCode == 401) {
        // Get.offAllNamed(LoginScreen.routeName);
      }

      return response;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Server Error";
    }
  }

  static Future<http.Response> get(String url,
      {Map<String, String>? headers}) async {
    try {
      var token = StorageHelper.getAccessToken();
      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      LogHelper.info("Post Request Header ==> $url",
          error: json.encode(headers));
      LogHelper.info("Post Request Response ==> $url", error: response.body);

      if (response.statusCode == 401) {
        // Get.find<CoreController>().logOut();///--------------------------------------------
        Get.closeAllSnackbars();
        GearSnackBar.info(
            title: "Session Expired",
            message: "Your session has expired!!. Please Log to continue");
      }
      return response;
    } catch (e) {
      log(e.toString());
      throw "Server Error";
    }
  }

  static Future<http.StreamedResponse> multiPart({
    String type = "POST",
    required String url,
    Map<String, String>? headers,
    Map<String, String>? fields,
    required List<http.MultipartFile> files,
  }) async {
    try {
      var token = StorageHelper.getAccessToken();
      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.MultipartRequest request =
          http.MultipartRequest(type, Uri.parse(url));

      request.headers.addAll(headers);
      if (fields != null) {
        request.fields.addAll(fields);
      }

      request.files.addAll(files);

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      log(json.encode(headers), name: "Get Request Header ==> $url");

      if (response.statusCode == 401) {
        // Get.find<CoreController>().logOut();-----------------------------------------------------------
        Get.closeAllSnackbars();
        GearSnackBar.info(
            title: "Session Expired",
            message: "Your session has expired!!. Please Log to continue");
      }
      return response;
    } catch (e, s) {
      log(
        "Server Error",
        error: e,
        stackTrace: s,
      );
      throw "Server Error";
    }
  }
}
