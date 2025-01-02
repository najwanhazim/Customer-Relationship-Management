import 'package:crm/function/repository/async_helper.dart';
import 'package:crm/function/retrofit/api_server.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/meeting.dart';
import '../retrofit/client_util.dart';

class MeetingRepository {
  Future<List<MeetingNote>> getMeetingByUser() async{
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<MeetingNote> meetingList;

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getMeetingByUser(bearer);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        meetingList = MeetingNote.fromJsonList(response);

        return meetingList;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<MeetingNote>> getMeetingList(String contact_id) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<MeetingNote> meetingList;

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getMeetingByContact(bearer, contact_id);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        meetingList = MeetingNote.fromJsonList(response);

        return meetingList;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<MeetingNote>> getMeetingListByLead(String lead_id) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<MeetingNote> meetingList;

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getMeetingByLead(bearer, lead_id);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        meetingList = MeetingNote.fromJsonList(response);

        return meetingList;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<MeetingNote> addMeetingNote(MeetingNote meetingIn) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.createMeetingNote(bearer, meetingIn);
      if (response is Map<String, dynamic>) {
        return MeetingNote.fromJson(response);
      } else {
        throw Exception(
            "invalid response format: expected a Map<String, dynamic>");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<bool> assignMeeting(String meetingId, List<String>? contactIds,
      List<String>? participantIds, String? leadId) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    final body = {
      "contact_ids": contactIds,
      "participant_ids": participantIds,
      "lead_id": leadId,
      "meeting_notes_id": meetingId
    };

    try {
      final response = await client.assign_meeting_notes(bearer, body);

      if (response is bool) {
        return response;
      } else {
        print("Unexpected response type: $response");
        return false;
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }
}
