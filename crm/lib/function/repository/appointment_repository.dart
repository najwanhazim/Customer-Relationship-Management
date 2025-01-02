import 'package:crm/function/retrofit/api_server.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/appointment.dart';
import '../../utils/app_string_constant.dart';
import '../retrofit/client_util.dart';
import 'async_helper.dart';

class AppointmentRepository {

  Future<List<Appointment>> getAppointment() async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<Appointment> appointmentList;

    SharedPreferences prefs = await getSharedPreference();
    String? tokenAccess = prefs.getString(AppString.prefAccessToken);

    if (tokenAccess == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $tokenAccess";

    try {
      final response = await client.getAppointmentByUser(bearer);

      if (response is List<dynamic>) {
        appointmentList = Appointment.fromJsonList(response);

        return appointmentList;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<Appointment> addAppointment(Appointment appointmentIn) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearerToken = "Bearer $accessToken";

    try {
      final response = await client.createAppointment(bearerToken, appointmentIn);
      print("response: $response");

      if (response is Map<String, dynamic>) {
        return Appointment.fromJson(response);
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (e) {
      final errorMessage = clientReturn(e);
      throw Exception(errorMessage);
    }
  }

  Future<bool> assignAppointment(String appointmentId, List<String> participantIds) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      print("Error: Access token is missing");
      return false;
    }

    String bearer = "Bearer $accessToken";

    final body = {
      "appointment_id": appointmentId,
      "assigned_to": participantIds,
    };

    try {
      final response =
          await client.assignAppointment(bearer, body);

      // Ensure response is boolean
      if (response is bool) {
        return response;
      } else {
        print("Unexpected response type: $response");
        return false;
      }
    } catch (e) {
      print("Error during assign task action: $e");
      return false;
    }
  }
}