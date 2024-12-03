import 'package:crm/view/leads/edit_leads.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/leads.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../action/add_following_action.dart';
import '../meeting_notes/add_meeting_notes.dart';
import '../meeting_notes/edit_meeting_notes.dart';

class ViewLeads extends StatefulWidget {
  const ViewLeads(
      {Key? key,
      required this.lead,
      required this.allContact,
      required this.allTeam,
      required this.contactForms,
      required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final Leads lead;
  final List<String> allContact;
  final List<String> allTeam;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewLeads> createState() => _ViewLeadsState();
}

class _ViewLeadsState extends State<ViewLeads> {
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
                          allContacts: widget.allContact,
                          contactForms: widget.contactForms,
                          leadForms: widget.leadForms,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                color: Colors.grey, fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            widget.lead.scope,
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${widget.lead.client} - ${widget.lead.end_user}',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            widget.lead.location,
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                                          : widget.lead.status ==
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pageTitle(AppString.contactText),
                                      AppTheme.box10,
                                      SizedBox(
                                        height:
                                            100, // Set a fixed height to accommodate the horizontal ListView
                                        child: attendeesGenerator(),
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
                                    forms: widget.contactForms,
                                    allContacts: widget.allContact,
                                    allTeam: widget.allTeam,
                                    leadForms: widget.leadForms,
                                    leadLabel: widget.leadLabel,
                                  ));
                            }),
                            // Meeting History Section
                            Container(
                              decoration: BoxDecoration(color: Colors.pink[50]),
                              child: meetingHistory(
                                  context,
                                  widget.allContact,
                                  widget.allTeam,
                                  widget.contactForms,
                                  widget.leadForms,
                                  widget.leadLabel),
                            ),
                            // Follow Up Header
                            followUpHeader(() => bottomSheet(
                                  context,
                                  AddFollowingAction(
                                    allContact: widget.allContact,
                                    allTeam: widget.allTeam,
                                    contactForms: widget.contactForms,
                                    leadForms: widget.leadForms,
                                    leadLabel: widget.leadLabel,
                                  ),
                                )),
                            // Follow Up Action Section
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 600,
                              child: followUpAction(context, widget.allContact,
                                widget.allTeam,
                                widget.contactForms,
                                widget.leadForms,
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
