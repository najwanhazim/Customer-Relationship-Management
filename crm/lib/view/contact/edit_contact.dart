import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../function/bloc/contact_bloc.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key, required this.contact, required this.forms})
      : super(key: key);

  final Contact contact;
  final List<FormGroup> forms;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  BuildContext? _blocContext;
  late List<String> label1;
  late List<String> label2;
  late List<String> label3;

  ContactRepository contactRepository = ContactRepository();

  @override
  void initState() {
    super.initState();
    label1 = [
      widget.contact.fullname,
      widget.contact.position ?? "",
    ];
    label2 = [
      widget.contact.phone_no ?? "",
      widget.contact.email ?? "",
    ];
    label3 = [
      widget.contact.salutation,
      widget.contact.contact_type,
      widget.contact.source,
    ];
  }

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
                    pageTitle(AppString.editContact),
                    BlocProvider(
                      create: (context) => ContactBloc(contactRepository),
                      child: BlocConsumer<ContactBloc, ContactState>(
                        listener: (listenerContext, state) {
                          if (state is ContactError) {
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
                  backgroundColor:
                      Colors.transparent, // Fix for background issue
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding8,
                      child: SafeArea(
                        child: Form(
                          key: _formState,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: AppTheme.radius50,
                                backgroundColor: Colors.blue,
                              ),
                              // Form sections
                              reactiveForm(context, widget.forms[0], label1,
                                  hintText: true),
                              reactiveForm(context, widget.forms[1], label2,
                                  hintText: true),
                              reactiveForm(context, widget.forms[2], label3,
                                  hintText: true),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (widget.forms.every((form) => form.valid)) {
      final contact = updateContactFromForms(widget.forms, widget.contact);
      try{
        if(widget.contact.id != null){
          await sendContact(contact, widget.contact.id!);
        }
      } catch (e) {
        showToastError(context, "missing contact id");
      }
    } else {
      print('Form is not valid!');
    }
  }

  Contact updateContactFromForms(
      List<FormGroup> contactForms, Contact contact) {
    // Extract values from each form group
    final fullName = contactForms[0].control('fullname').value as String? ??
        contact.fullname;
    final position = contactForms[0].control('position').value as String? ??
        contact.position;
    final phoneNo = contactForms[1].control('phoneNumber').value as String? ??
        contact.phone_no;
    final email =
        contactForms[1].control('email').value as String? ?? contact.email;
    final salutation = contactForms[2].control('salutation').value as String? ??
        contact.salutation;
    final contactType =
        contactForms[2].control('contact_type').value as String? ??
            contact.contact_type;
    final source =
        contactForms[2].control('source').value as String? ?? contact.source;

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

  Future<void> sendContact(Contact contactIn, String contactId) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final contactBloc = BlocProvider.of<ContactBloc>(_blocContext!);
    contactBloc.add(UpdateContact(buildContext: context, contactIn: contactIn, contactId: contactId));
  }
}
