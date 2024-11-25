import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

import '../../db/contact.dart';
import '../../utils/app_theme_constant.dart';
import '../action/add_following_action.dart';

class AddMeetingNotes extends StatefulWidget {
  const AddMeetingNotes({Key? key, required this.contact, required this.forms, required this.allContacts, required this.allTeam})
      : super(key: key);

  final Contact contact;
  final List<String> allContacts;
  final List<String> allTeam;
  final List<FormGroup> forms;

  @override
  State<AddMeetingNotes> createState() => _AddMeetingNotesState();
}

class _AddMeetingNotesState extends State<AddMeetingNotes> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final List<String> label1 = [
    'Title',
    'Date, Time, & Location',
    'Team Member'
  ];
  final List<String> label2 = ['Contact', 'Leads'];
  final List<String> label3 = [
    'Meeting Methods',
    'Notes',
  ];

  List<String> option = ['Face To Face', 'Online', 'Phone Call'];

  late String selected;

//  final MultiSelectController<Contact> controller = MultiSelectController<Contact>();

  // List<DropdownItem<Contact>> items = [];

  @override
  void initState() {
    super.initState();
    selected = '';
    // contactItem();
  }

  // List<DropdownItem<Contact>> contactItem() {
  //   return widget.allContacts.map((contact) {
  //     return DropdownItem<Contact>(
  //       label: '${contact.firstName} ${contact.lastName}',
  //       value: contact,
  //     );
  //   }).toList();
  // }

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
                    pageTitle(AppString.newMeeting),
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
                            inputField(label1[0]),
                            displayInField(context, label1[1],
                                function: () =>
                                    bottomSheet(context, const PickDate())),
                            multipleDropdown(
                              context,
                              label1[2],
                              items: widget.allTeam,
                            ),
                            multipleDropdown(context, label2[0],
                                isShow: true,
                                buttonFunction: () =>
                                    addContact(context, widget.forms),
                                items: widget.allContacts),
                            singleDropdown(context, label2[1],
                                isShow: true,
                                buttonFunction: () =>
                                    addLeads(context, widget.forms, widget.allContacts)),
                            singleDropdown(context, label3[0]),
                            inputField(label3[1], longInput: true),
                            const SizedBox(height: 10),
                            followUpHeader(() => bottomSheet(context, AddFollowingAction(allContact: widget.allContacts, allTeam: widget.allTeam, contactForms: widget.forms,))),
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

  // Future pickDateSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //       ),
  //       backgroundColor: AppTheme.grey,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return PickDate();
  //       });
  // }

  // Widget meetingMethod(String labelText) {
  //   return Padding(
  //     padding: AppTheme.paddingTop,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         shape: BoxShape.rectangle,
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(10),
  //           bottom: Radius.circular(10),
  //         ),
  //       ),
  //       child: Expanded(
  //         child: DropdownSearch<String>(
  //           mode: Mode.MENU,
  //           showSelectedItems: true,
  //           dropdownButtonProps: const IconButtonProps(icon: SizedBox.shrink()),
  //           items: option,
  //           dropdownSearchDecoration: InputDecoration(
  //             labelText: labelText,
  //             labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
  //             border: InputBorder.none,
  //             contentPadding:
  //                 const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
