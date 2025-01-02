import 'package:crm/db/appointment.dart';
import 'package:crm/db/contact.dart';
import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/function/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/user.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import 'edit_appointment.dart';

class ViewAppointment extends StatefulWidget {
  const ViewAppointment(
      {Key? key,
      required this.forms,
      required this.allContacts,
      required this.appointment})
      : super(key: key);

  final List<FormGroup> forms;
  final List<Contact> allContacts;
  final Appointment appointment;

  @override
  State<ViewAppointment> createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
  ContactRepository contactRepository = ContactRepository();
  List<Contact> contactList = [];
  UserRepository userRepository = UserRepository();
  User? user;

  @override
  void initState() {
    super.initState();
    getContact();
    getUser();
  }

  Future<void> getContact() async {
    try {
      if (widget.appointment.id != null) {
        contactList = await contactRepository
            .getContactByAppointmentId(widget.appointment.id!);
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async {
    try {
      if (widget.appointment.created_by != null) {
        user = await userRepository.getUserById(widget.appointment.created_by!);
      } else {
        return;
      }
    } catch (e) {
      print(e);
    } finally{
      setState(() {
        
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.grey, // Set background to grey
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SizedBox(
          height: AppTheme.sheetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: AppTheme.bottomSheet,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cancelButton(context),
                    pageTitle(AppString.appointmentDetails),
                    editButton(
                        context,
                        EditAppointment(
                          forms: widget.forms,
                          allContacts: widget.allContacts,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors
                      .transparent, // Prevents the Scaffold from overriding the background
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    padding: AppTheme.padding10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    widget.appointment.title,
                                    style: AppTheme.titleContainer,
                                  ),
                                  Text(
                                    formatDateTime(
                                        widget.appointment.start_time),
                                    style: AppTheme.subTitleContainer,
                                  ),
                                  Text(
                                    widget.appointment.location,
                                    style: AppTheme.subTitleContainer,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text('Attendees',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  SizedBox(
                                      height: 100,
                                      child: attendeesGenerator(contactList)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text('Notes',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  widget.appointment.notes != null
                                      ? Text(
                                          widget.appointment.notes,
                                          style: AppTheme.subTitleContainer,
                                        )
                                      : const Text(
                                          "No Notes",
                                          style: AppTheme.subTitleContainer,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            width: double.infinity,
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Created By',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: AppTheme.radius30,
                                        backgroundColor: Colors.blue,
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Space between avatar and text
                                      Text(user?.login_id ?? 'Unknown User'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
