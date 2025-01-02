import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../utils/app_string_constant.dart';
import '../retrofit/api_server.dart';
import '../retrofit/client_util.dart';
import 'async_helper.dart';

class LeadsRepository {
  Future<List<Leads>> getLeadsByUserId() async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Leads> allLeads;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getLeadsByUser(bearer);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        allLeads = Leads.fromJsonList(response);

        return allLeads;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<Leads>> getLeadsByMeetingId(String meetingId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Leads> allLeads;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getLeadsByMeeting(bearer, meetingId);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        allLeads = Leads.fromJsonList(response);

        return allLeads;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> getLeadsByActionId(String actionId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    Leads lead;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getLeadsByAction(bearer, actionId);

      if (response is Map<String, dynamic>) {
      return response;
    } else {
      throw Exception("Invalid response format: expected a Map");
    }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<bool> createLead(Leads leadIn, List<String> contactIds) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    final body = {
      "lead_in" : leadIn,
      "contact_id" : contactIds
    };

    try {
      final response = await client.createLead(bearer, body);
      return true;
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }
}
