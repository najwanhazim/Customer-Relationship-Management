import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/contact/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({Key? key, required this.contact, required this.forms}) : super(key:key);

  final Contact contact;
  final List<FormGroup> forms;

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
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
                    backButton(context),
                    pageTitle('${widget.contact.salutation} ${widget.contact.firstName} ${widget.contact.lastName}'),
                    TextButton(
                      onPressed: () {
                        editContact(context);
                      },
                      child: Text(
                        AppString.editText,
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
                  backgroundColor: Colors.transparent,
                  body: Container(
                    margin: AppTheme.padding10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                  bottom: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                '${widget.contact.contactType}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: AppTheme.radius50,
                          backgroundColor: Colors.blue,
                        ),
                        AppTheme.box20,
                        displayInField(context, widget.contact.position, null),
                        displayInField(context, widget.contact.phone, null),
                        displayInField(context, widget.contact.email, null),
                        displayInField(context, widget.contact.notes, null),
                        AppTheme.box30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Meeting History',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Add',
                                  style: TextStyle(color: AppTheme.redMaroon),
                                )),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: meetingHistory(context)),
                        followUpHeader(),
                        followUpAction(context),
                      ],
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

  Future editContact(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return EditContact(contact: widget.contact, forms: widget.forms);
      },
    );
  }
}