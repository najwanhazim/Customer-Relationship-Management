import 'package:crm/db/task_action_with_user.dart';
import 'package:crm/function/repository/async_helper.dart';
import 'package:crm/function/retrofit/api_server.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/task_action.dart';
import '../../utils/app_string_constant.dart';
import '../retrofit/client_util.dart';

class TaskActionRepository {
  Future<List<TaskActionWithUser>> getTaskActionByContact(
      String contact_id) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<TaskActionWithUser> taskList;

    SharedPreferences prefs = await getSharedPreference();
    String? tokenAccess = prefs.getString(AppString.prefAccessToken);

    if (tokenAccess == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $tokenAccess";

    try {
      final response = await client.getTaskByContact(bearer, contact_id);

      if (response is List<dynamic>) {
        taskList = TaskActionWithUser.fromJsonList(response);

        return taskList;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<TaskAction>> getTaskActionByUser() async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<TaskAction> taskList;

    SharedPreferences prefs = await getSharedPreference();
    String? tokenAccess = prefs.getString(AppString.prefAccessToken);

    if (tokenAccess == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $tokenAccess";

    try {
      final response = await client.getTaskByUser(bearer);

      if (response is List<dynamic>) {
        taskList = TaskAction.fromJsonList(response);

        return taskList;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<TaskActionWithUser>> getTaskActionByLead(
      String leadId) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    List<TaskActionWithUser> taskList;

    SharedPreferences prefs = await getSharedPreference();
    String? tokenAccess = prefs.getString(AppString.prefAccessToken);

    if (tokenAccess == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $tokenAccess";

    try {
      final response = await client.getTaskByLead(bearer, leadId);

      if (response is List<dynamic>) {
        taskList = TaskActionWithUser.fromJsonList(response);

        return taskList;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<TaskAction> getTaskByAction(
      String actionId) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);
    TaskAction taskAction;

    SharedPreferences prefs = await getSharedPreference();
    String? tokenAccess = prefs.getString(AppString.prefAccessToken);

    if (tokenAccess == null) {
      throw Exception("Access token is missing");
    }

    String bearer = "Bearer $tokenAccess";

    try {
      final response = await client.getTaskByAction(bearer, actionId);

      if (response is dynamic) {
        taskAction = TaskAction.fromJson(response);

        return taskAction;
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (obj) {
      final errorMessage = clientReturn(obj);
      throw Exception(errorMessage);
    }
  }

  Future<List<TaskAction>> addTaskAction(TaskAction actionIn) async {
    final Dio dio = Dio();
    final APIServer client = APIServer(dio, baseUrl: AppString.defaultServer);

    SharedPreferences prefs = await getSharedPreference();
    String? accessToken = prefs.getString(AppString.prefAccessToken);

    if (accessToken == null) {
      throw Exception("Access token is missing");
    }

    String bearerToken = "Bearer $accessToken";

    try {
      final response = await client.createTaskAction(bearerToken, actionIn);

      if (response is List<dynamic>) {
        return TaskAction.fromJsonList(response);
      } else {
        throw Exception("invalid response format: expected a List");
      }
    } catch (e) {
      final errorMessage = clientReturn(e);
      throw Exception(errorMessage);
    }
  }

  Future<bool> assignAction(String taskId, List<String> participantIds) async {
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
      "task_action_id": taskId,
      "assigned_to": participantIds,
    };

    try {
      final response =
          await client.assign_follow_up_action(bearer, body);

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
