import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/contact/add_contact.dart';
import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

import '../../db/contact.dart';
import '../../utils/app_theme_constant.dart';

class AddMeetingNotes extends StatefulWidget {
  const AddMeetingNotes({Key? key, required this.allContacts, required this.forms})
      : super(key: key);

  final List<Contact> allContacts;
  final List<FormGroup> forms;

  @override
  State<AddMeetingNotes> createState() => _AddMeetingNotesState();
}

class _AddMeetingNotesState extends State<AddMeetingNotes> {
  final List<String> label1 = [
    'Title',
    'Date, Time, & Location',
  ];
  final List<String> label2 = ['Attendees', 'Leads'];
  final List<String> label3 = [
    'Meeting Methods',
    'Notes',
  ];

  // final controller = MultiSelectController<Contact>();

  // List<DropdownItem<Contact>> items = [];

  @override
  void initState() {
    super.initState();
    // items = contactItem();
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
                      child: Column(
                        children: [
                          inputField(label1[0]),
                          displayInField(
                              context, label1[1], function: () => pickDateSheet(context)),
                          displayInField(context, label2[0], isShow: true, buttonFunction: () => addContact(context, widget.forms)
                              ),
                          // dropDown(),
                          displayInField(context, label2[1], 
                              isShow: true, buttonFunction: () => addLeads(context)),
                          inputField(label3[0]),
                          inputField(label3[1], longInput: true),
                          SizedBox(height: 10),
                          followUpHeader(),
                          // followUpAction(context)
                        ],
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

  Future pickDateSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: AppTheme.grey,
        isScrollControlled: true,
        builder: (context) {
          return PickDate();
        });
  }

  // Widget dropDown() {
  //   return MultiDropdown(
  //     items: items,
  //     controller: controller,
  //     enabled: true,
  //     searchEnabled: true,
  //     chipDecoration: const ChipDecoration(
  //       backgroundColor: Colors.yellow,
  //       wrap: true,
  //       runSpacing: 2,
  //       spacing: 10,
  //     ),
  //     fieldDecoration: FieldDecoration(
  //       hintText: 'attendees',
  //       hintStyle: const TextStyle(color: Colors.black87),
  //       prefixIcon: const Icon(CupertinoIcons.flag),
  //       showClearIcon: false,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: const BorderSide(color: Colors.grey),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Colors.black87,
  //         ),
  //       ),
  //     ),
  //     dropdownDecoration: const DropdownDecoration(
  //       marginTop: 2,
  //       maxHeight: 500,
  //       header: Padding(
  //         padding: EdgeInsets.all(8),
  //         child: Text(
  //           'Select attendees from the list',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //     dropdownItemDecoration: DropdownItemDecoration(
  //       selectedIcon: const Icon(Icons.check_box, color: Colors.green),
  //       disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
  //     ),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select a attendee';
  //       }
  //       return null;
  //     },
  //     onSelectionChange: (selectedItems) {
  //       debugPrint("OnSelectionChange: $selectedItems");
  //     },
  //   );
  // }
}
