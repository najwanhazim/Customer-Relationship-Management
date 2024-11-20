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
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppTheme.redMaroon,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Text(
                      'New Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Save',
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
                  backgroundColor: Colors
                      .transparent, // Prevents the Scaffold from overriding the background
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding8,
                      child: SafeArea(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: AppTheme.radius50,
                              backgroundColor: Colors.blue,
                            ),
                            // Form sections
                            reactiveForm(widget.forms[0], label1),
                            reactiveForm(widget.forms[1], label2),
                            reactiveForm(widget.forms[2], label3),
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
