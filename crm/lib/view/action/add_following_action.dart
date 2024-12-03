import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddFollowingAction extends StatefulWidget {
  const AddFollowingAction({Key? key, required this.allTeam, required this.allContact, required this.contactForms, required this.leadForms, required this.leadLabel}) : super(key: key);

  final List<String> allTeam;
  final List<String> allContact;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<AddFollowingAction> createState() => _AddFollowingActionState();
}

class _AddFollowingActionState extends State<AddFollowingAction> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final label = [
    'Action',
    'Person In Charge',
    'Contact',
    'Leads',
    'Remarks',
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
                    pageTitle(AppString.action),
                    saveButton(context),
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
                            inputField(label[0]),
                            multipleDropdown(context, label[1], items: widget.allTeam),
                            multipleDropdown(context, label[2], items: widget.allContact, isShow: true, buttonFunction: () => addContact(context, widget.contactForms),),
                            singleDropdown(context, label[3], isShow: true, buttonFunction: () => addLeads(context, widget.contactForms, widget.allContact, widget.leadLabel, widget.leadForms)),
                            inputField(label[4], longInput: true)
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
