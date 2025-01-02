import 'package:crm/function/repository/async_helper.dart';
import 'package:crm/function/retrofit/api_server.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_string_constant.dart';

class TeamRepository {
  Future<bool> assignTeam(List<String> participantIds) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      print("Error: Access token is missing");
      return false;
    }

    String bearer = "Bearer $accessToken";

    try {
      final response =
          await client.assignTeam(bearer, participantIds);

      // Ensure response is boolean
      if (response is bool) {
        return response;
      } else {
        print("Unexpected response type: $response");
        return false;
      }
    } catch (e) {
      print("Error during assign team member: $e");
      return false;
    }
  }

  Future<bool> unassignUser(String userId) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      print("Error: Access token is missing");
      return false;
    }

    String bearer = "Bearer $accessToken";

    try {
      final response =
          await client.unassignTeam(bearer, userId);

      // Ensure response is boolean
      if (response is bool) {
        return response;
      } else {
        print("Unexpected response type: $response");
        return false;
      }
    } catch (e) {
      print("Error during assign team member: $e");
      return false;
    }
  }
}