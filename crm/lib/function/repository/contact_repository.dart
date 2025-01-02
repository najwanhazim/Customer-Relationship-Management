import 'package:crm/function/repository/async_helper.dart';
import 'package:crm/function/retrofit/api_server.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/contact.dart';
import '../../utils/app_string_constant.dart';
import '../retrofit/client_util.dart';

class ContactRepository {
  Future<List<Contact>> getContactByUserId() async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Contact> contacts;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getContactByUser(bearer);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        contacts = Contact.fromJsonList(response);
        return contacts;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<Contact>> getContactByAppointmentId(String appointmentId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Contact> contacts;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getContactByAppointment(bearer, appointmentId);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        contacts = Contact.fromJsonList(response);
        return contacts;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<Contact>> getContactByLeadId(String leadId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Contact> contacts;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getContactByLead(bearer, leadId);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        contacts = Contact.fromJsonList(response);
        return contacts;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<Contact> getContactByActionId(String actionId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    Contact contact;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getContactByAction(bearer, actionId);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is Map<String, dynamic>) {
        contact = Contact.fromJson(response);
        return contact;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<Contact>> getContactByMeetingId(String meetingId) async {
    final Dio dio = Dio();
    final APIServer client =
        APIServer(dio, baseUrl: AppString.defaultServer.toString());
    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);
    List<Contact> contacts;

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $accessToken";

    try {
      final response = await client.getContactByMeeting(bearer, meetingId);

      // Ensure `response` is a List before passing to fromJsonList
      if (response is List<dynamic>) {
        contacts = Contact.fromJsonList(response);
        return contacts;
      } else {
        throw Exception("Invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<bool> createContact(Contact contactIn) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken != null) {
      String bearerToken = "Bearer $accessToken";
      try {
        print(contactIn);
        await client.createContact(bearerToken, contactIn);
        return true;
      } catch (e) {
        // Log the error if needed
        print("Error during createContact: $e");
        return false;
      }
    }

    return false;
  }

  Future<bool> updateContact(Contact contactIn, String contactId) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken != null) {
      String bearerToken = "Bearer $accessToken";
      try {
        await client.updateContact(bearerToken, contactIn, contactId);
        return true;
      } catch (e) {
        // Log the error if needed
        print("Error during createContact: $e");
        return false;
      }
    }

    return false;
  }
}
