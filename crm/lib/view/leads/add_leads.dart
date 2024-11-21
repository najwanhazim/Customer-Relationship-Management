import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddLeads extends StatefulWidget {
  const AddLeads({super.key});

  @override
  State<AddLeads> createState() => AddLeadsState();
}

class AddLeadsState extends State<AddLeads> {
  final List<String> label = [
    'Portfolio',
    'Leads Title',
    'Value(RM)',
    'Scope',
    'Client',
    'End User',
    'Location(Region)',
    'Contact',
    'Lead Status'
  ];

  final FormGroup forms = FormGroup({
    'portfolio': FormControl<String>(),
    'leadsTitle': FormControl<String>(),
    'value': FormControl<String>(),
    'scope': FormControl<String>(),
    'client': FormControl<String>(),
    'endUser': FormControl<String>(),
    'location': FormControl<String>(),
    'contact': FormControl<String>(),
    'leadStatus': FormControl<String>(),
  });

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
                        child: pageTitle(AppString.leadsText),
                      ),
                      Align(
                        alignment: Alignment
                            .centerRight, 
                        child: saveButton(),
                      ),
                    ],
                  )),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    margin: AppTheme.padding8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [reactiveForm(context, forms, label)],
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
