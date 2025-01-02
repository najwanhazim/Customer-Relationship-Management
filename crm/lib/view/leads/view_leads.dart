import 'package:crm/view/leads/edit_leads.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../db/meeting.dart';
import '../../db/task_action_with_user.dart';
import '../../db/user.dart';
import '../../function/repository/contact_repository.dart';
import '../../function/repository/leads_reposiotry.dart';
import '../../function/repository/meeting_repository.dart';
import '../../function/repository/task_action_repository.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../action/add_following_action.dart';
import '../meeting_notes/add_meeting_notes.dart';
import '../meeting_notes/edit_meeting_notes.dart';

class ViewLeads extends StatefulWidget {
  const ViewLeads(
      {Key? key,
      required this.allLeads,
      required this.lead,
      required this.allContacts,
      required this.allUsers,
      required this.contactForms,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final Leads lead;
  final List<Leads> allLeads;
  final List<Contact> allContacts;
  final List<User> allUsers;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewLeads> createState() => _ViewLeadsState();
}

class _ViewLeadsState extends State<ViewLeads> {
  List<MeetingNote> meetingList = [];
  MeetingRepository meetingRepository = MeetingRepository();
  List<TaskActionWithUser> taskList = [];
  TaskActionRepository taskActionRepository = TaskActionRepository();
  List<Contact> contactListDisplay = [];
  ContactRepository contactRepository = ContactRepository();
  List<Leads> leadsList = [];
  LeadsRepository leadsRepository = LeadsRepository();

  @override
  void initState() {
    super.initState();
    getMeeting();
    getFollowUpAction();
    getContactByLead();
    getAllLead();
  }

  Future<void> getMeeting() async {
    try {
      if (widget.lead.id != null) {
        meetingList =
            await meetingRepository.getMeetingListByLead(widget.lead.id!);
      } else {
        showToastError(context, "missing lead");
      }
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

  Future<void> getFollowUpAction() async {
    try {
      taskList =
          await taskActionRepository.getTaskActionByLead(widget.lead.id!);
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

  Future<void> getContactByLead() async {
    try {
      if (widget.lead.id != null) {
        contactListDisplay =
            await contactRepository.getContactByLeadId(widget.lead.id!);
      } else {
        showToastError(context, "lead id is missing");
      }
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

  Future<void> getAllLead() async {
    try {
      leadsList = await leadsRepository.getLeadsByUserId();
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
                    pageTitle(AppString.leadDetail),
                    editButton(
                        context,
                        EditLeads(
                          allContacts: widget.allContacts,
                          contactForms: widget.contactForms,
                          // leadForms: widget.leadForms,
                          leadLabel: widget.leadLabel,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding10,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: AppTheme.container,
                              child: Padding(
                                padding: AppTheme.padding8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          pageTitle(widget.lead.title),
                                          Text(
                                            widget.lead.portfolio,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            widget.lead.scope,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${widget.lead.client} - ${widget.lead.end_user}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            widget.lead.location,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.lead.status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: widget.lead.status ==
                                                      'Prospect'
                                                  ? Colors.green
                                                  : widget.lead.status ==
                                                          'Opportunity'
                                                      ? Colors.blue
                                                      : widget.lead.status ==
                                                              'Sales Won'
                                                          ? Colors.purple
                                                          : widget.lead
                                                                      .status ==
                                                                  'Sales Lost'
                                                              ? Colors.red
                                                              : Colors.black,
                                            ),
                                          ),
                                          AppTheme.box70,
                                          pageTitle(
                                              'RM ${widget.lead.value.toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      pageTitle(AppString.contactText),
                                      AppTheme.box10,
                                      SizedBox(
                                        height:
                                            100, // Set a fixed height to accommodate the horizontal ListView
                                        child: attendeesGenerator(
                                            contactListDisplay),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            meetingHeader(() {
                              bottomSheet(
                                  context,
                                  AddMeetingNotes(
                                    taskList: taskList,
                                    allContacts: widget.allContacts,
                                    allUser: widget.allUsers,
                                    allLeads: leadsList,
                                    contactForms: widget.contactForms,
                                    // leadForms: widget.leadForms,
                                    leadLabel: widget.leadLabel,
                                  ));
                            }),
                            // Meeting History Section
                            Container(
                              decoration: BoxDecoration(color: Colors.pink[50]),
                              child: meetingHistory(
                                  context,
                                  meetingList,
                                  widget.allContacts,
                                  widget.allUsers,
                                  widget.contactForms,
                                  widget.leadLabel),
                            ),
                            // Follow Up Header
                            followUpHeader(() => bottomSheet(
                                  context,
                                  AddFollowingAction(
                                    allContact: widget.allContacts,
                                    allUser: widget.allUsers,
                                    contactForms: widget.contactForms,
                                    leadLabel: widget.leadLabel,
                                    allLeads: widget.allLeads,
                                  ),
                                )),
                            // Follow Up Action Section
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 600,
                              child: followUpAction(
                                  context,
                                  taskList,
                                  widget.allContacts,
                                  widget.allUsers,
                                  widget.contactForms,
                                  widget.leadLabel),
                            ),
                          ],
                        ),
                      ),
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
