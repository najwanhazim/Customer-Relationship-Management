import 'package:crm/db/contact.dart';
import 'package:crm/function/bloc/action_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/leads.dart';
import '../../db/task_action.dart';
import '../../db/user.dart';
import '../../function/repository/task_action_repository.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddFollowingAction extends StatefulWidget {
  const AddFollowingAction(
      {Key? key,
      required this.allUser,
      required this.allContact,
      required this.contactForms,
      // required this.leadForms,
      required this.leadLabel,
      required this.allLeads})
      : super(key: key);

  final List<User> allUser;
  final List<Contact> allContact;
  final List<Leads> allLeads;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<AddFollowingAction> createState() => _AddFollowingActionState();
}

class _AddFollowingActionState extends State<AddFollowingAction> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TaskActionRepository taskActionRepository = TaskActionRepository();
  TextEditingController actionController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController leadsController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  BuildContext? _blocContext;

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
                    BlocProvider(
                      create: (context) => ActionBloc(taskActionRepository),
                      child: BlocConsumer<ActionBloc, ActionState>(
                        listener: (listenerContext, state) {
                          if (state is ActionError) {
                            showToastError(context, state.message);
                          } else if (state is ActionLoaded) {
                            showToastError(context, state.message);
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
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    margin: AppTheme.padding8,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formState,
                        child: Column(
                          children: [
                            inputField(label[0], controller: actionController),
                            multipleDropdown(context, label[1],
                                items: widget.allUser,
                                controller: userController,
                                getDisplayValue: (user) =>
                                    (user as User).login_id,
                                getStoredValue: (user) => (user as User).id!),
                            multipleDropdown(
                              context,
                              label[2],
                              controller: contactController,
                              items: widget.allContact,
                              getDisplayValue: (contact) =>
                                  (contact as Contact).fullname,
                              getStoredValue: (contact) =>
                                  (contact as Contact).id!,
                              isShow: true,
                              buttonFunction: () =>
                                  addContact(context, widget.contactForms),
                            ),
                            singleDropdown(context, label[3],
                                isShow: true,
                                controller: leadsController,
                                items: widget.allLeads,
                                getDisplayValue: (lead) =>
                                    (lead as Leads).title,
                                getStoredValue: (lead) => (lead as Leads).id!,
                                buttonFunction: () => addLeads(
                                    context,
                                    widget.contactForms,
                                    widget.allContact,
                                    widget.allUser,
                                    widget.leadLabel,)),
                            singleDropdownWihtoutObject(context, "status",
                                items: AppString.statusHolder,
                                controller: statusController),
                            inputField(label[4],
                                longInput: true, controller: remarksController)
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

      final action = createActionFromForms();
      await sendAction(action);
    } else {
      print('Form is not valid!');
    }
  }

  TaskAction createActionFromForms() {
    return TaskAction(
        action: actionController.text,
        remarks: remarksController.text,
        status: statusController.text,
        lead_id: leadsController.text,
        contact_ids: contactController.text.split(','));
  }

  Future<void> sendAction(TaskAction actionIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final actionBloc = BlocProvider.of<ActionBloc>(_blocContext!);
    actionBloc.add(CreateAction(
        buildContext: context,
        actionIn: actionIn,
        participants: userController.text.split(',')));
  }
}
