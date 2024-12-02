import 'package:crm/view/meeting_notes/edit_meeting_notes.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../contact/edit_contact.dart';

class ViewMeetingNotes extends StatefulWidget {
  const ViewMeetingNotes(
      {Key? key,
      required this.meetingData,
      required this.allContacts,
      required this.allTeam,
      required this.contactForms,
      required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final Map<String, String> meetingData;
  final List<String> allContacts;
  final List<String> allTeam;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewMeetingNotes> createState() => _ViewMeetingNotesState();
}

class _ViewMeetingNotesState extends State<ViewMeetingNotes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.grey,
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
                    backButton(context),
                    pageTitle(AppString.meetingDetail),
                    editButton(
                        context,
                        EditMeetingNotes(
                          allContacts: widget.allContacts,
                          allTeam: widget.allTeam,
                          contactForms: widget.contactForms,
                          leadForms: widget.leadForms,
                          leadLabel: widget.leadLabel,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    margin: AppTheme.padding10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: AppTheme.container,
                          child: Padding(
                            padding: AppTheme.padding8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pageTitle('Coffee Session'),
                                AppTheme.box10,
                                Text('date',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15)),
                                Text('date',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15)),
                                Text('location',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15))
                              ],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pageTitle('Attendees'),
                                  AppTheme.box10,
                                  SizedBox(
                                    height:
                                        100, // Set a fixed height to accommodate the horizontal ListView
                                    child: ListView.builder(
                                      scrollDirection: Axis
                                          .horizontal, // Enable horizontal scrolling
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
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
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pageTitle('Leads'),
                                  AppTheme.box10,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pageTitle('Notes'),
                                  AppTheme.box10,
                                  Text('adfadf fjsdnfsjnfasdfnsjdfnjksfnjkdfd',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
