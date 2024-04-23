import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../model/access_token_model.dart';
import '../../model/user_model.dart';
import '../constants/storage_keys.dart';
import 'log_helper.dart';



class StorageHelper {
  static saveAccessToken(AccessToken token) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.ACCESSTOKEN, json.encode(token.toJson()));
    } catch (_) {
      // throw "Unable to save token";
    }
  }

  static AccessToken? getAccessToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(
          json.decode(box.read(StorageKeys.ACCESSTOKEN)) ?? "");

      return token;
    } catch (_) {
      return null;
    }
  }

  static saveUser(User user) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.USER, json.encode(user.toJson()));
    } catch (_) {
      throw "Unable to save user";
    }
  }

  static User? getUser() {
    try {
      final box = GetStorage();
      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)) ?? "");
      return user;
    } catch (_) {
      return null;
    }
  }

  static void clear() {
    final box = GetStorage();
    LogHelper.error(
        "clear ------------------>${box.hasData(StorageKeys.USER)}");

    box.erase();

    LogHelper.error("clear------------------>${box.hasData(StorageKeys.USER)}");
  }

  static bool isOnboarded() {
    try {
      final box = GetStorage();
      bool onBoarded = box.read(StorageKeys.ONBOARDING);

      LogHelper.info("isOnboarded  value in storage --------$onBoarded");
      return onBoarded;
    } catch (e, s) {
      LogHelper.info("isOnboarded error function is called in-----------catch");
      return false;
    }
  }

  static Future<void> setOnBoarded() async {
    try {
      LogHelper.info(
          "isOnboarded function is called    write --------storage helpers");

      final box = GetStorage();
      await box.write(StorageKeys.ONBOARDING, true);
    } catch (e) {
      LogHelper.info(e.toString());
    }
  }
}
