import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import 'edit_appointment.dart';

class ViewAppointment extends StatefulWidget {
  const ViewAppointment({Key? key, required this.forms, required this.allContacts}) : super(key: key);

  final List<FormGroup> forms;
  final List<String> allContacts;

  @override
  State<ViewAppointment> createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
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
                    editButton(context, EditAppointment(forms: widget.forms, allContacts: widget.allContacts,)),
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
                                children: const [
                                  Text(
                                    'Title',
                                    style: AppTheme.titleContainer,
                                  ),
                                  Text(
                                    'sub',
                                    style: AppTheme.subTitleContainer,
                                  ),
                                  Text(
                                    'dajksdnkadnjadnsajdnajdnakdasjdasjkdnadjasdnadnakdjadadaskdnjasdnkadkadnkads',
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
                                      height: 100, child: attendeesGenerator()),
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
                                children: const [
                                  Text('Notes',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  Text('bdkajwbdkabfkjbfsjbfsndfbsdnmfbsdnmfbsdnfbsdnmfbsdmnfbsnmbdfnmsbfnmsbfnmsdbfsnmfbsnmfbsnmf' , style: AppTheme.subTitleContainer,)
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
                                  Text('Created By',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
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
                                      Text('Aiman'),
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
