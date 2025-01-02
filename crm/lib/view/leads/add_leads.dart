import 'package:crm/db/contact.dart';
import 'package:crm/function/repository/leads_reposiotry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/leads.dart';
import '../../db/user.dart';
import '../../function/bloc/lead_bloc.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddLeads extends StatefulWidget {
  const AddLeads(
      {Key? key,
      required this.contactForms,
      required this.allContacts,
      required this.allUsers,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final List<FormGroup> contactForms;
  final List<Contact> allContacts;
  final List<User> allUsers;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<AddLeads> createState() => AddLeadsState();
}

class AddLeadsState extends State<AddLeads> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController portfolioController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController scopeController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController endUserController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  BuildContext? _blocContext;
  LeadsRepository leadsRepository = LeadsRepository();

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
                      alignment: Alignment.centerRight,
                      child: BlocProvider(
                        create: (context) => LeadBloc(leadsRepository),
                        child: BlocConsumer<LeadBloc, LeadState>(
                          listener: (listenerContext, state) {
                            if (state is LeadError) {
                              showToastError(context, state.message);
                            } else if (state is LeadLoaded) {
                              showToastError(context, state.message);
                            }
                          },
                          builder: (blocContext, state) {
                            _blocContext = blocContext;
                            return saveButton(context, sendFunction: onSave);
                          },
                        ),
                      ),
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
                            singleDropdownWihtoutObject(
                              context,
                              widget.leadLabel[0],
                              items: AppString.portfolioHolder,
                              controller: portfolioController,
                            ),
                            inputField(widget.leadLabel[1],
                                controller: titleController),
                            inputField(widget.leadLabel[2],
                                controller: valueController),
                            inputField(widget.leadLabel[3],
                                controller: scopeController),
                            inputField(widget.leadLabel[4],
                                controller: clientController),
                            inputField(widget.leadLabel[5],
                                controller: endUserController),
                            inputField(widget.leadLabel[6],
                                controller: locationController),
                            // multipleDropdown(context, widget.leadLabel[7],
                            //     controller: userController,
                            //     items: widget.allUsers,
                            //     getDisplayValue: (user) =>
                            //         (user as User).login_id,
                            //     getStoredValue: (user) => (user as User).id!),
                            multipleDropdown(
                              context,
                              widget.leadLabel[8],
                              controller: contactController,
                              items: widget.allContacts,
                              getDisplayValue: (contact) =>
                                  (contact as Contact).fullname,
                              getStoredValue: (contact) =>
                                  (contact as Contact).id!,
                              isShow: true,
                              buttonFunction: () =>
                                  addContact(context, widget.contactForms),
                            ),
                            singleDropdownWihtoutObject(
                                context, widget.leadLabel[9],
                                items: AppString.leadStatusHolder,
                                controller: statusController),
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
    if (_formState.currentState != null &&
        _formState.currentState!.validate()) {
      _formState.currentState!.save();

      final lead = createLeadFromForms();
      await sendAction(lead);
    } else {
      showToastError(context, 'Form is not valid!');
    }
  }

  Leads createLeadFromForms() {
    return Leads(
        portfolio: portfolioController.text,
        title: titleController.text,
        scope: scopeController.text,
        client: clientController.text,
        end_user: endUserController.text,
        location: locationController.text,
        status: statusController.text,
        value: double.tryParse(valueController.text) ?? 0.0);
  }

  Future<void> sendAction(Leads leadIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final actionBloc = BlocProvider.of<LeadBloc>(_blocContext!);
    actionBloc.add(CreateLead(
        buildContext: context,
        leadIn: leadIn,
        contactIds: contactController.text.split(",")));
  }
}
