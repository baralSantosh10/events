import 'dart:convert';

import 'package:event/core/utils/constants/apis.dart';
import 'package:http/http.dart' as http;

import '../model/access_token_model.dart';
import '../model/user_model.dart';
import '../utils/constants/messages.dart';
import '../utils/helpers/app_requests.dart';
import '../utils/helpers/log_helper.dart';
import '../utils/helpers/storage_helper.dart';

class AuthRepo {
  static Future<void> signIn({
    required User user,
    required String password,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.signupUrl;

      var body = {
        "name": user.name,
        "phonenumber": user.phonenumber,
        "email": user.email,
        "address": user.address,
        "gender": user.gender,
        "password": password,
      };

      http.Response response = await AppRequest.post(url, body: body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        var user = User.fromJson(data['data']['user']);
        var accessToken = AccessToken.fromJson(data['data']['token']);

        // StorageHelper.saveAccessToken(accessToken);
        // StorageHelper.saveUser(user);
        onSuccess(user);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.signupUrl, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> login({
    required String email,
    required String password,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.loginUrl;
      var body = {
        "email": email,
        "password": password,
      };
      http.Response response = await AppRequest.post(url, body: body);
      dynamic data = json.decode(response.body);

      if (data['status']) {
        var user = User.fromJson(data['data']['user']);
        var accessToken = AccessToken.fromJson(data['data']['token']);
        print("=====u=====>$user");
        print("=====t====>$accessToken");
        StorageHelper.saveAccessToken(accessToken);
        StorageHelper.saveUser(user);
        onSuccess(user);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.loginUrl, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> forgotPassword({
    required String email,
    required Function(String tempToken) onSuccess,
    required Function(String messaqe) onError,
  }) async {
    try {
      String url = Api.forgotPassword;
      var body = {
        "email": email,
      };

      http.Response response = await AppRequest.post(url, body: body);

      var data = json.decode(response.body);

      if (data['status']) {
        var temp_token = data['data']['temp_token'];

        print("-------------${temp_token}");

        onSuccess(temp_token);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.loginUrl, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> verifyOtp({
    required String otp,
    required String userToken,
    required Function(String message) onSuccess,
    required Function(String messaqe) onError,
  }) async {
    try {
      String url = Api.verifyOTP;
      var body = {
        "otp": otp,
        "temp_token": userToken,
      };

      http.Response response = await AppRequest.post(url, body: body);

      var data = json.decode(response.body);

      if (data['status']) {
        var msg = data['message'];

        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.verifyOTP, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> resetPassword({
    required String password,
    required String token,
    required String otp,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.resetPassword;
      var body = {
        "otp": otp,
        "temp_token": token,
        "new_password": password,
      };
      http.Response response = await AppRequest.post(url, body: body);
      var data = json.decode(response.body);

      if (data['status']) {
        var message = data['message'];
        onSuccess(message);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.resetPassword, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.changePw;
      var body = {
        "old_password": oldPassword,
        "new_password": newPassword,
      };
      LogHelper.info(url);
      http.Response response = await AppRequest.post(url, body: body);
      var data = json.decode(response.body);
      if (data['status']) {
        // var user = User.fromJson(data['data']);
        var user = User.fromJson(data['data']['user']);

        LogHelper.warning(user.toString());
        StorageHelper.saveUser(user);
        onSuccess(user);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.changePw, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateProfile({
    required User user,
    // required Function(User user) onSuccess,
    // required Function(User user) onSuccess,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateProfile;

      print("--------------------------------------$url");
      var body = {
        "name": user.name,
        "phonenumber": user.phonenumber,
        "address": user.address,
        "gender": user.gender,
        "email": user.email,
      };

      http.Response response = await AppRequest.post(url, body: body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        var user = User.fromJson(data['data']['user']);

        print("=====u=====>$user");
        StorageHelper.saveUser(user);
        // onSuccess(user);
        onSuccess(data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateProfile, error: e, stackTrace: s);
      onError(Messages.error);

      print(e);
    }
  }
}
