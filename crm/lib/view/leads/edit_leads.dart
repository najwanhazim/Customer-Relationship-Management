import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditLeads extends StatefulWidget {
  const EditLeads({Key? key, required this.contactForms, required this.allContacts, required this.leadForms, required this.leadLabel}) : super(key: key);

  final List<FormGroup> contactForms;
  final List<String> allContacts;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<EditLeads> createState() => _EditLeadsState();
}

class _EditLeadsState extends State<EditLeads> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.grey,
          borderRadius: const BorderRadius.vertical(
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: pageTitle(AppString.editLead),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: saveButton(context),
                    ),
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
                          mainAxisSize: MainAxisSize
                              .min, // Ensure Column takes only required space
                          children: [
                            singleDropdown(context, widget.leadLabel[0]),
                            inputField(widget.leadLabel[1]),
                            inputField(widget.leadLabel[2]),
                            inputField(widget.leadLabel[3]),
                            inputField(widget.leadLabel[4]),
                            inputField(widget.leadLabel[5]),
                            inputField(widget.leadLabel[6]),
                            multipleDropdown(
                              context,
                              widget.leadLabel[7],
                              isShow: true,
                              buttonFunction: () =>
                                  addContact(context, widget.contactForms),
                              items: widget.allContacts,
                            ),
                            singleDropdown(context, widget.leadLabel[8]),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
