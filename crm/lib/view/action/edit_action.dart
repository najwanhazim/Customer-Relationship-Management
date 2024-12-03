import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditAction extends StatefulWidget {
  const EditAction({Key? key, required this.allTeam, required this.allContact, required this.contactForms, required this.leadForms, required this.leadLabel}) : super(key: key);

  final List<String> allTeam;
  final List<String> allContact;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<EditAction> createState() => _EditActionState();
}

class _EditActionState extends State<EditAction> {
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
                    pageTitle(AppString.editAction),
                    saveButton(context)
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        inputField('Phone Call'),
                        multipleDropdown(context, 'Team',
                            items: widget.allTeam),
                        multipleDropdown(
                          context,
                          'Contact',
                          items: widget.allContact,
                          isShow: true,
                          buttonFunction: () =>
                              addContact(context, widget.contactForms),
                        ),
                        singleDropdown(context, 'Leads',
                            isShow: true,
                            buttonFunction: () => addLeads(
                                context,
                                widget.contactForms,
                                widget.allContact,
                                widget.leadLabel,
                                widget.leadForms)),
                        inputField('Remarks', longInput: true),
                        deleteButton(context)
                      ],
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
