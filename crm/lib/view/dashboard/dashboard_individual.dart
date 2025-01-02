import 'dart:core';
import 'dart:ffi';

import 'package:crm/db/appointment.dart';
import 'package:crm/db/task_action.dart';
import 'package:crm/db/user.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/dashboard/dashboard_team_stats.dart';
import 'package:flutter/material.dart';

import '../../function/repository/appointment_repository.dart';
import '../../function/repository/task_action_repository.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_theme_constant.dart';

class DashboardIndividual extends StatefulWidget {
  const DashboardIndividual({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<DashboardIndividual> createState() => _DashboardIndividualState();
}

class _DashboardIndividualState extends State<DashboardIndividual> {
  UserRepository userRepository = UserRepository();
  AppointmentRepository appointmentRepository = AppointmentRepository();
  TaskActionRepository taskActionRepository = TaskActionRepository();
  List<Appointment> appointmentList = [];
  List<TaskAction> taskList = [];
  User? user;

  String search = '';
  double valueSales = 0;
  double valueLeads = 0;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => getUser(widget.userId));
    super.initState();
    valueLeads = calculateProgress(isLead: true);
    valueSales = calculateProgress(isLead: false);
    getUser(widget.userId);
    getAppointment();
    getTask();
  }

  Future getUser(String userId) async {
    try {
      user = await userRepository.getUserById(userId);
      setState(() {});
    } catch (e) {
      print("Error while fetching user: $e");
    }
  }

  Future getAppointment() async {
    try {
      appointmentList = await appointmentRepository.getAppointment();
    } catch (e) {
      print("Error while fetching user: $e");
    } finally {
      setState(() {});
    }
  }

  Future getTask() async {
    try {
      taskList = await taskActionRepository.getTaskActionByUser();
    } catch (e) {
      print("Error while fetching user: $e");
    } finally {
      setState(() {});
    }
  }

  double calculateProgress({required bool isLead}) {
    if (isLead) {
      double value1 = 80;
      double value2 = 1000;

      return value1 / value2;
    } else {
      double value1 = 650000;
      double value2 = 1000000;

      return value1 / value2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.scrollDelta! > 0) {
              // Scroll downward
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardStats()));
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: AppTheme.padding8,
                child: Text(
                  "Hi ${user?.login_id ?? ''},",
                  style: const TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              searchBar(search),
              dashboard(appointmentList, taskList),
              AppTheme.box10,
              Padding(
                padding: AppTheme.paddingTepi,
                child: const Text(
                  'Goals',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: AppTheme.padding,
                child: Container(
                  padding: AppTheme.padding10,
                  color: AppTheme.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '80',
                        style: TextStyle(fontSize: 35),
                      ),
                      const Text(
                        'Leads',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        color: Colors.green,
                        value: valueLeads,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: AppTheme.padding,
                child: Container(
                  padding: AppTheme.padding10,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'RM 650,000.00',
                        style: TextStyle(fontSize: 35),
                      ),
                      const Text(
                        'Sales Won',
                        style: TextStyle(fontSize: 20),
                      ),
                      AppTheme.box20,
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        color: Colors.green,
                        value: valueSales,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: speedDial(),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }
}
