import 'package:crm/db/contact.dart';
import 'package:crm/db/leads.dart';
import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/view/meeting_notes/edit_meeting_notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/meeting.dart';
import '../../db/user.dart';
import '../../function/repository/leads_reposiotry.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../contact/edit_contact.dart';

class ViewMeetingNotes extends StatefulWidget {
  const ViewMeetingNotes(
      {Key? key,
      required this.meetingData,
      required this.allContacts,
      required this.allUser,
      required this.contactForms,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final MeetingNote meetingData;
  final List<Contact> allContacts;
  final List<User> allUser;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewMeetingNotes> createState() => _ViewMeetingNotesState();
}

class _ViewMeetingNotesState extends State<ViewMeetingNotes> {
  List<Contact> contacts = [];
  ContactRepository contactRepository = ContactRepository();
  LeadsRepository leadsRepository = LeadsRepository();

  @override
  void initState() {
    super.initState();
    getContactByMeeting();
  }

  Future<void> getContactByMeeting() async {
    try {
      if (widget.meetingData.id != null) {
        contacts = await contactRepository
            .getContactByMeetingId(widget.meetingData.id!);
      } else {
        showToastError(context, "missing meeting id");
      }
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

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
                          allUser: widget.allUser,
                          contactForms: widget.contactForms,
                          // leadForms: widget.leadForms,
                          leadLabel: widget.leadLabel,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Meeting Details
                          Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pageTitle(widget.meetingData.title),
                                  AppTheme.box10,
                                  Text(
                                    formatDateTime(
                                        widget.meetingData.start_time),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  Text(
                                    formatDateTime(widget.meetingData.end_time),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  Text(
                                    "Location: ${widget.meetingData.location}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Attendees Section
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
                                          100, // Fixed height for horizontal ListView
                                      child: attendeesGenerator(contacts),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Leads Section
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
                                    SizedBox(
                                      height: 70, // Adjust height as needed
                                      child: FutureBuilder<List<Leads>>(
                                        future:
                                            leadsRepository.getLeadsByMeetingId(
                                                widget.meetingData.id!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasError) {
                                              showToastError(context,
                                                  snapshot.error.toString());
                                              return Center(
                                                  child: Text(
                                                      "Failed to load leads"));
                                            } else if (snapshot.hasData) {
                                              final leads = snapshot.data!;
                                              if (leads.isEmpty) {
                                                return const Center(
                                                  child: Text("No Leads Found"),
                                                );
                                              }
                                              return ListView.builder(
                                                itemCount: leads.length,
                                                itemBuilder: (context, index) {
                                                  final lead = leads[index];
                                                  return ListTile(
                                                    title: Text(lead.title),
                                                    subtitle:
                                                        Text(lead.portfolio),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                          return const Center(
                                            child: Text("No Leads Available"),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Notes Section
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
                                    Text(
                                      widget.meetingData.notes,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
