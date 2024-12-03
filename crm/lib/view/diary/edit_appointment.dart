import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditAppointment extends StatefulWidget {
  const EditAppointment({Key? key, required this.forms, required this.allContacts}) : super(key: key);

  final List<FormGroup> forms;
  final List<String> allContacts;

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

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
                    pageTitle(AppString.editAppointment),
                    saveButton(context),
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            inputField('Title', hintText: true),
                            inputField('Location', hintText: true),
                            singleDropdown(context, 'Medium'),
                            AppTheme.box10,
                            pickDateTime(context, 'Start', timePicker: timePicker(), datePicker: datePicker()),
                            pickDateTime(context, 'End', timePicker: timePicker(), datePicker: datePicker()),
                            AppTheme.box10,
                            multipleDropdown(context, 'Team',
                                isShow: true,
                                buttonFunction: () =>
                                    addContact(context, widget.forms),
                                items: widget.allContacts),
                            multipleDropdown(context, 'Contact',
                                isShow: true,
                                buttonFunction: () =>
                                    addContact(context, widget.forms),
                                items: widget.allContacts),
                            inputField('Notes', longInput: true, hintText: true),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: deleteButton(context),
                            )
                          ],
                        ),
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

  Widget timePicker() {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.time,
      initTime: DateTime.now().toLocal(),
      use24hFormat: false,
      timeFormat: 'h:mm a',
      onChange: (dateTime) {
        print(dateTime);
      },
    );
  }

  Widget datePicker() {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.date,
      initTime: DateTime.now().toLocal(),
      onChange: (dateTime) {
        print(dateTime);
      },
    );
  }
}