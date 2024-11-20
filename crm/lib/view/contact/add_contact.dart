import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key, required this.forms}) : super(key: key);

  final List<FormGroup> forms;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  final List<String> label1 = [
    'First Name',
    'Last Name',
    'Company',
    'Position'
  ];
  final List<String> label2 = ['Phone Number', 'Email'];
  final List<String> label3 = [
    'Salutation',
    'Contact Type',
    'Source',
    'Remarks'
  ];

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
                    cancelButton(context),
                    pageTitle(AppString.newContact),
                    saveButton(),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors
                      .transparent, // Prevents the Scaffold from overriding the background
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SafeArea(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: AppTheme.radius50,
                              backgroundColor: Colors.blue,
                            ),
                            // Form sections
                            reactiveForm(context, widget.forms[0], label1),
                            reactiveForm(context, widget.forms[1], label2),
                            reactiveForm(context, widget.forms[2], label3),
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
}
