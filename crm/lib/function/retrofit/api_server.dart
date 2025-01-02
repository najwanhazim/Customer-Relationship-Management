import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/appointment.dart';
import '../../db/meeting.dart';
import '../../db/task_action.dart';
import '../../db/contact.dart';
import '../../db/user.dart';
import '../../utils/app_string_constant.dart';

part 'api_server.g.dart';

@RestApi(baseUrl: AppString.defaultServer)
abstract class APIServer {
  factory APIServer(Dio dio, {String baseUrl}) = _APIServer;

  //----------- authorization -----------

  @POST("login/access-token")
  @FormUrlEncoded()
  Future<dynamic> login(
      @Field("username") String email, @Field("password") String password);

  //----------- User -----------

  @GET("/users/get_user_by_id")
  Future<dynamic> getUserById(@Header("Authorization") String authHeader,
      @Query("user_id") String userId);

  @GET("/user/list")
  Future<dynamic> getAllUser(@Header("Authorization") String authHeader);

  @GET("/user/list/by_team")
  Future<dynamic> getUserByTeam(@Header("Authorization") String authHeader);

  @POST("/user/register")
  Future<dynamic> createUser(@Body() User user);

  //----------- contact -----------

  @GET("/contact/list")
  Future<dynamic> getContactByUser(@Header("Authorization") String authHeader);

  @POST("/contact/add")
  Future<dynamic> createContact(
      @Header("Authorization") String authHeader, @Body() Contact contactIn);

  @POST("/contact/update")
  Future<dynamic> updateContact(@Header("Authorization") String authHeader,
      @Body() Contact contactIn, @Body() String contactId);

  @GET("/contact/list/by_lead")
  Future<dynamic> getContactByLead(@Header("Authorization") String authHeader,
      @Query("lead_id") String leadId);

  @GET("/contact/list/by_appointment")
  Future<dynamic> getContactByAppointment(
      @Header("Authorization") String authHeader,
      @Query("appointment_id") String appointmentId);

  @GET("/contact/list/by_meeting")
  Future<dynamic> getContactByMeeting(
      @Header("Authorization") String authHeader,
      @Query("meeting_id") String meetingId);

  @GET("/contact/by_action")
  Future<dynamic> getContactByAction(@Header("Authorization") String authHeader,
      @Query("action_id") String actionId);

  // ----------- meeting -----------

  @GET("/meeting-notes/list")
  Future<dynamic> getMeetingByUser(@Header("Authorization") String authHeader);

  @GET("/meeting_notes/list/get_meeting_by_contact")
  Future<dynamic> getMeetingByContact(
      @Header("Authorization") String authHeader,
      @Query("contact_id") String contactId);

  @GET("/meeting_notes/list/get_meeting_by_lead")
  Future<dynamic> getMeetingByLead(@Header("Authorization") String authHeader,
      @Query("lead_id") String leadId);

  @POST("/meeting-notes/add")
  Future<dynamic> createMeetingNote(
      @Header("Authorization") String authHeader, @Body() MeetingNote noteIn);

  @POST("/meeting-notes/assign")
  Future<bool> assign_meeting_notes(@Header("Authorization") String authHeader,
      @Body() Map<String, dynamic> body);

  // ----------- task action -----------

  @GET("/follow_up/list/by_contact_id")
  Future<dynamic> getTaskByContact(@Header("Authorization") String authHeader,
      @Query("contact_id") String contactId);

  @GET("/follow_up/list/by_lead_id")
  Future<dynamic> getTaskByLead(@Header("Authorization") String authHeader,
      @Query("lead_id") String leadId);

  @POST("/follow-up/action/add")
  Future<dynamic> createTaskAction(
      @Header("Authorization") String authHeader, @Body() TaskAction actionIn);

  @POST("/follow-up/assign")
  Future<bool> assign_follow_up_action(
      @Header("Authorization") String authHeader,
      @Body() Map<String, dynamic> body);

  @GET("/follow_up/by_action")
  Future<dynamic> getTaskByAction(@Header("Authorization") String authHeader,
      @Query("action_id") String actionId);

  @GET("/follow-up/list")
  Future<dynamic> getTaskByUser(@Header("Authorization") String authHeader);

  // ----------- Leads -----------

  @GET("/lead/list")
  Future<dynamic> getLeadsByUser(@Header("Authorization") String authHeader);

  @POST("/lead/add")
  Future<dynamic> createLead(@Header("Authorization") String authHeader,
      @Body() Map<String, dynamic> body);

  @GET("/lead/list/get_lead_by_meeting")
  Future<dynamic> getLeadsByMeeting(@Header("Authorization") String authHeader,
      @Query("meeting_id") String meetingId);

  @GET("/lead/list/get_lead_by_action")
  Future<dynamic> getLeadsByAction(@Header("Authorization") String authHeader,
      @Query("action_id") String actionId);

  // ----------- appoinment -----------

  @POST("/appointment/add")
  Future<dynamic> createAppointment(@Header("Authorization") String authHeader,
      @Body() Appointment appointmentIn);

  @POST("/appointment/assign")
  Future<dynamic> assignAppointment(@Header("Authorization") String authHeader,
      @Body() Map<String, dynamic> body);

  @GET("/appointment/list/user")
  Future<dynamic> getAppointmentByUser(
    @Header("Authorization") String authHeader,
  );

  //----------- Team -----------

  @POST("/team/assign")
  Future<dynamic> assignTeam(@Header("Authorization") String authHeader,
      @Body() List<String> participantIds);

  @POST("/team/unassign")
  Future<dynamic> unassignTeam(@Header("Authorization") String authHeader,
      @Body() String userId);
}
