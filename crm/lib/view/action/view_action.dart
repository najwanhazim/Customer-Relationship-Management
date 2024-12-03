import 'package:crm/view/action/edit_action.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ViewAction extends StatefulWidget {
  const ViewAction({Key? key, required this.allTeam, required this.allContact, required this.contactForms, required this.leadForms, required this.leadLabel}) : super(key: key);

  final List<String> allTeam;
  final List<String> allContact;
  final List<FormGroup> contactForms;
  final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewAction> createState() => _ViewActionState();
}

class _ViewActionState extends State<ViewAction> {
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
                    pageTitle(AppString.actionDetails),
                    editButton(context, EditAction(allTeam: widget.allTeam, allContact: widget.allContact, contactForms: widget.contactForms, leadForms: widget.leadForms, leadLabel: widget.leadLabel,))
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
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text(
                                    'Phone',
                                    style: AppTheme.titleContainer,
                                  ),
                                  Text(
                                    'with Contact',
                                    style: AppTheme.subTitleContainer,
                                  ),
                                  Text(
                                    'Assign by User',
                                    style: AppTheme.subTitleContainer,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text('Leads',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  Text(
                                    'bdkajwbdkabfkjbfsjbfsndfbsdnmfbsdnmfbsdnfbsdnmfbsdmnfbsnmbdfnmsbfnmsbfnmsdbfsnmfbsnmfbsnmf',
                                    style: AppTheme.subTitleContainer,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingTop,
                          child: Container(
                            decoration: AppTheme.container,
                            child: Padding(
                              padding: AppTheme.padding8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text('Remarks',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  Text(
                                    'bdkajwbdkabfkjbfsjbfsndfbsdnmfbsdnmfbsdnfbsdnmfbsdmnfbsnmbdfnmsbfnmsbfnmsdbfsnmfbsnmfbsnmf',
                                    style: AppTheme.subTitleContainer,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
