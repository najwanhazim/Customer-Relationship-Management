import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../function/bloc/contact_bloc.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key, required this.forms}) : super(key: key);

  final List<FormGroup> forms;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final ContactRepository contactRepository = ContactRepository();
  BuildContext? _blocContext;

  final List<String> label1 = ['Full Name', 'Position'];
  final List<String> label2 = ['Phone Number', 'Email'];
  final List<String> label3 = ['Salutation', 'Contact Type', 'Source'];

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
                    pageTitle(AppString.newContact),
                    BlocProvider(
                      create: (context) => ContactBloc(contactRepository),
                      child: BlocConsumer<ContactBloc, ContactState>(
                        listener: (listenerContext, state) {
                          if (state is ContactError) {
                            print("success add");
                            showToastError(context, state.message);
                          } else if (state is ContactLoaded) {
                            showToastSuccess(context, state.message);
                          }
                        },
                        builder: (blocContext, state) {
                          _blocContext = blocContext;
                          return saveButton(context, sendFunction: onSave);
                        },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (widget.forms.every((form) => form.valid)) {
      final contact = createContactFromForms(widget.forms);
      await sendContact(contact);
    } else {
      print('Form is not valid!');
    }
  }

  Contact createContactFromForms(List<FormGroup> contactForms) {
    // Extract values from each form group
    final fullName = contactForms[0].control('fullname').value as String? ?? '';
    final position = contactForms[0].control('position').value as String? ?? '';
    final phoneNo =
        contactForms[1].control('phoneNumber').value as String? ?? '';
    final email = contactForms[1].control('email').value as String? ?? '';
    final salutation =
        contactForms[2].control('salutation').value as String? ?? '';
    final contactType =
        contactForms[2].control('contact_type').value as String? ?? '';
    final source = contactForms[2].control('source').value as String? ?? '';

    // Create the ContactIn instance
    return Contact(
      fullname: fullName,
      position: position,
      phone_no: phoneNo,
      email: email,
      salutation: salutation,
      contact_type: contactType,
      source: source,
    );
  }

  Future<void> sendContact(Contact contactIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final contactBloc = BlocProvider.of<ContactBloc>(_blocContext!);
    contactBloc.add(CreateContact(buildContext: context, contactIn: contactIn));
  }
}
