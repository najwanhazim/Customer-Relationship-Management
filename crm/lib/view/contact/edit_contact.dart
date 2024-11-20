import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key, required this.contact, required this.forms}) : super(key: key);

  final Contact contact;
  final List<FormGroup> forms;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late List<String> label1;
  late List<String> label2;
  late List<String> label3;

  @override
  void initState() {
    super.initState();
    label1 = [
      widget.contact.firstName,
      widget.contact.lastName,
      widget.contact.company,
      widget.contact.position,
    ];
    label2 = [
      widget.contact.phone,
      widget.contact.email,
    ];
    label3 = [
      widget.contact.salutation,
      widget.contact.contactType,
      widget.contact.source ?? '',
      widget.contact.notes ?? '',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    'Edit Contact',
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
    );
  }
}
