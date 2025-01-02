import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crm/db/user.dart';
import 'package:crm/function/repository/async_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_string_constant.dart';
import '../retrofit/api_server.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../retrofit/client_util.dart';

class UserRepository implements Exception {
  Future<bool> verifyLogin(
      String username, String password, BuildContext context) async {
    String? setAccessToken;
    String? setUserId;

    /// setting up Dio client for API call
    final Dio dio = Dio();
    final client = APIServer(dio, baseUrl: AppString.defaultServer.toString());

    /// encryption setup
    encrypt.Key key =
        encrypt.Key.fromUtf8(AppString.encryptionKey); //from string to encrypt
    encrypt.Encrypter encrypter =
        encrypt.Encrypter(encrypt.AES(key)); //encrypt and decrypt

    /// checking connectivity (online or offline)
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      //online Login
      await client.login(username, password).then((it) async {
        setAccessToken = it[AppString.prefAccessToken];
        setUserId = it[AppString.prefUserId];

        /// encrypt the password
        // encrypt.IV salt = encrypt.IV.fromSecureRandom(36); //pass length
        // encrypt.Encrypted passwordEncrypted =
        //     encrypter.encrypt(password, iv: salt);
      }).catchError((Object obj) {
        final errorMessage = clientReturn(obj);
        throw Exception(errorMessage);
      });
    }

    if (setAccessToken != null && setUserId != null) {
      SharedPreferences prefs = await getSharedPreference();

      await prefs.setString(AppString.prefAccessToken, setAccessToken!);
      await prefs.setString(AppString.prefUserId, setUserId!);

      return true;
    } else {
      return false;
    }
  }

  static void logout(BuildContext buildContext) async {
    try {
      SharedPreferences prefs = await getSharedPreference();
      await prefs.remove(AppString.prefAccessToken);
      await prefs.remove(AppString.prefUserId);
    } catch (e) {
      throw Exception("Failed to sign out");
    }
  }

  Future<bool> createUser(User user) async {
    print("user: ${user.email}");
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    // SharedPreferences prefs = await getSharedPreference();
    // String? accessToken = prefs.getString(AppString.prefAccessToken);
      // String bearerToken = "Bearer $accessToken";
      try {
        await client.createUser(user);
        print("test");
        return true;
      } catch (e) {
        // Log the error if needed
        print("Error during create user: $e");
        return false;
      }

    return false;
  }

  Future<dynamic> getUserById(String userId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    User user;

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken != null) {
      String bearerToken = "Bearer $accessToken";

      try {
        final response = await client.getUserById(bearerToken, userId);

        user = User.fromJson(response);

        return user;
      } // catch (e) {
      //   print("Error while fetching user: $e");
      // }
      catch (obj) {
        final errorMessage = clientReturn(obj);
        throw Exception(errorMessage);
      }
    }
  }

  Future<List<User>> getAllUser() async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<User> allUser;

    SharedPreferences prefs = await getSharedPreference();
    String? token = prefs.getString(AppString.prefAccessToken);

    if (token == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $token";

    try {
      final response = await client.getAllUser(bearer);

      if (response is List<dynamic>) {
        allUser = User.fromJsonList(response);

        return allUser;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<User>> getUserByTeam() async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<User> allUser;

    SharedPreferences prefs = await getSharedPreference();
    String? token = prefs.getString(AppString.prefAccessToken);

    if (token == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $token";

    try {
      final response = await client.getUserByTeam(bearer);

      if (response is List<dynamic>) {
        allUser = User.fromJsonList(response);

        return allUser;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }
}
