import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../action/add_following_action.dart';

class EditMeetingNotes extends StatefulWidget {
  const EditMeetingNotes(
      {Key? key,
      required this.allContacts,
      required this.allTeam,
      required this.contactForms,
      required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final List<String> allContacts;
  final List<String> allTeam;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<EditMeetingNotes> createState() => _EditMeetingNotesState();
}

class _EditMeetingNotesState extends State<EditMeetingNotes> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

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
          height: 750,
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
                    pageTitle(AppString.editMeeting),
                    saveButton(),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    margin: AppTheme.padding8,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formState,
                        child: Column(
                          children: [
                            inputField('Coffee Session', hintText: true),
                            displayInField(context, '15th Cotober',
                                function: () =>
                                    bottomSheet(context, const PickDate())),
                            multipleDropdown(
                              context,
                              'Team member',
                              items: widget.allTeam,
                            ),
                            multipleDropdown(context, "contact",
                                isShow: true,
                                buttonFunction: () =>
                                    addContact(context, widget.contactForms),
                                items: widget.allContacts),
                            singleDropdown(context, 'leads',
                                isShow: true,
                                buttonFunction: () => addLeads(
                                    context,
                                    widget.contactForms,
                                    widget.allContacts,
                                    widget.leadLabel,
                                    widget.leadForms)),
                            singleDropdown(context, 'meeting method'),
                            inputField('Coffee Session',
                                hintText: true, longInput: true),
                            const SizedBox(height: 10),
                            followUpHeader(() => bottomSheet(
                                context,
                                AddFollowingAction(
                                  allContact: widget.allContacts,
                                  allTeam: widget.allTeam,
                                  contactForms: widget.contactForms,
                                  leadForms: widget.leadForms,
                                  leadLabel: widget.leadLabel,
                                ))),
                            Container(
                                child:
                                    followUpAction(context, shrinkWrap: true)),
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