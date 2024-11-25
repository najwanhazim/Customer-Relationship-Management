import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/action/add_following_action.dart';
import 'package:crm/view/contact/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../meeting_notes/add_meeting_notes.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({Key? key, required this.contact, required this.contactForms})
      : super(key: key);

  final Contact contact;
  final List<FormGroup> contactForms;

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  final List<String> allContact = [
    'Ammar',
    'Azri',
    'Naiem',
    'Din',
    'Najwan',
  ];

  final List<String> allTeam = [
    'Wan',
    'Raimy',
    'Sai',
    'Syahmi',
    'Amir',
  ];
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
          height: AppTheme.usableHeight(context),
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
                    pageTitle(
                        '${widget.contact.salutation} ${widget.contact.firstName} ${widget.contact.lastName}'),
                    TextButton(
                      onPressed: () {
                        bottomSheet(
                            context,
                            EditContact(
                                contact: widget.contact, forms: widget.contactForms));
                      },
                      child: Text(
                        AppString.editText,
                        style: TextStyle(
                          color: AppTheme.redMaroon,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    margin: AppTheme.padding10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                  bottom: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                '${widget.contact.contactType}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: AppTheme.radius50,
                          backgroundColor: Colors.blue,
                        ),
                        AppTheme.box20,
                        displayInField(
                          context,
                          widget.contact.position,
                        ),
                        displayInField(
                          context,
                          widget.contact.phone,
                        ),
                        displayInField(
                          context,
                          widget.contact.email,
                        ),
                        displayInField(
                          context,
                          widget.contact.notes,
                        ),
                        AppTheme.box30,
                        meetingHeader(() {
                          bottomSheet(
                              context,
                              AddMeetingNotes(
                                  contact: widget.contact,
                                  forms: widget.contactForms,
                                  allContacts: allContact,
                                  allTeam: allTeam,));
                        }),
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: meetingHistory(context, allContact, allTeam, widget.contactForms)),
                        followUpHeader(() => bottomSheet(context, AddFollowingAction(allContact: allContact, allTeam: allTeam, contactForms: widget.contactForms,))),
                        Expanded(child: followUpAction(context)),
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

  // Future editContact(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //     ),
  //     backgroundColor: AppTheme.grey,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return EditContact(contact: widget.contact, forms: widget.forms);
  //     },
  //   );
  // }

  // Future addMeeting(
  //     BuildContext context, Contact contact, List<FormGroup> forms) {
  //   return showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //       ),
  //       backgroundColor: AppTheme.grey,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return AddMeetingNotes(contact: contact, forms: forms);
  //       });
  // }
}
