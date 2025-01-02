import 'package:crm/db/contact.dart';
import 'package:crm/db/leads.dart';
import 'package:crm/db/task_action.dart';
import 'package:crm/db/task_action_with_user.dart';
import 'package:crm/function/repository/leads_reposiotry.dart';
import 'package:crm/view/action/edit_action.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/user.dart';
import '../../function/repository/contact_repository.dart';
import '../../function/repository/task_action_repository.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ViewAction extends StatefulWidget {
  const ViewAction(
      {Key? key,
      required this.taskData,
      // required this.contactName,
      required this.allUser,
      required this.allContact,
      required this.contactForms,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final TaskActionWithUser taskData;
  // final String contactName;
  final List<User> allUser;
  final List<Contact> allContact;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewAction> createState() => _ViewActionState();
}

class _ViewActionState extends State<ViewAction> {
  TaskActionRepository taskActionRepository = TaskActionRepository();
  LeadsRepository leadsRepository = LeadsRepository();
  ContactRepository contactRepository = ContactRepository();
  Contact? contact;
  String? actionRemark;
  Leads? lead;

  void initState() {
    super.initState();
    getLead();
    getContact();
  }

  Future<void> getLead() async {
    try {
      final response = await leadsRepository
          .getLeadsByActionId(widget.taskData.task_action_id);

      final responseData = response as Map<String, dynamic>?;

      if (responseData != null) {
        lead = responseData['leads'] != null
            ? Leads.fromJson(responseData['leads'])
            : null;

        actionRemark = responseData['action_remark'] ?? "No remarks available";
      } else {
        throw Exception("No response data received");
      }
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

  Future<void> getContact() async {
    try {
      contact = await contactRepository
          .getContactByActionId(widget.taskData.task_action_id);
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {});
    }
  }

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
                    editButton(
                        context,
                        EditAction(
                          allUser: widget.allUser,
                          allContact: widget.allContact,
                          contactForms: widget.contactForms,
                          // leadForms: widget.leadForms,
                          leadLabel: widget.leadLabel,
                        ))
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
                                children: [
                                  Text(
                                    widget.taskData.action,
                                    style: AppTheme.titleContainer,
                                  ),
                                  contact != null
                                      ? Text(
                                          'with ${contact!.fullname}',
                                          style: AppTheme.subTitleContainer,
                                        )
                                      : Text(
                                          'No contact available',
                                          style: AppTheme.subTitleContainer,
                                        ),
                                  Text(
                                    'Assign to ${widget.taskData.assigned_to}',
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
                                children: [
                                  Text('Leads',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  // SizedBox(
                                  //   height: 30, // Adjust height as needed
                                  //   child: FutureBuilder<Leads>(
                                  //     future:
                                  //         leadsRepository.getLeadsByActionId(
                                  //             widget.taskData.task_action_id!),
                                  //     builder: (context, snapshot) {
                                  //       if (snapshot.connectionState ==
                                  //           ConnectionState.waiting) {
                                  //         return Center(
                                  //             child:
                                  //                 CircularProgressIndicator());
                                  //       } else if (snapshot.connectionState ==
                                  //           ConnectionState.done) {
                                  //         if (snapshot.hasError) {
                                  //           showToastError(context,
                                  //               snapshot.error.toString());
                                  //           return Center(
                                  //               child: Text(
                                  //                   "Failed to load leads"));
                                  //         } else if (snapshot.hasData) {
                                  //           final lead = snapshot.data!;
                                  //           return Text(lead.title);
                                  //         }
                                  //       }
                                  //       return const Center(
                                  //         child: Text("No Leads Available"),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  lead != null && lead!.title != null
                                      ? Text(lead!.title)
                                      : Text("No lead found"),
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
                                children: [
                                  Text('Remarks',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  AppTheme.box10,
                                  Text(
                                    actionRemark ?? "No remarks available",
                                    style: AppTheme.subTitleContainer,
                                  ),
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
