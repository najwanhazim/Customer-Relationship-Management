import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../db/meeting.dart';
import '../../db/task_action_with_user.dart';
import '../../db/user.dart';
import '../../function/bloc/meeting_bloc.dart';
import '../../function/repository/meeting_repository.dart';
import '../../utils/app_theme_constant.dart';
import '../action/add_following_action.dart';

class AddMeetingNotes extends StatefulWidget {
  const AddMeetingNotes(
      {Key? key,
      required this.taskList,
      required this.contactForms,
      required this.allContacts,
      required this.allUser,
      required this.allLeads,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final List<TaskActionWithUser> taskList;
  final List<Contact> allContacts;
  final List<User> allUser;
  final List<Leads> allLeads;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<AddMeetingNotes> createState() => _AddMeetingNotesState();
}

class _AddMeetingNotesState extends State<AddMeetingNotes> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  MeetingRepository meetingRepository = MeetingRepository();

  TextEditingController titleController = TextEditingController();
  DateTime? startTime;
  DateTime? endTime;
  TextEditingController locationController = TextEditingController();
  TextEditingController methodsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController leadController = TextEditingController();

  BuildContext? _blocContext;

  final List<String> label1 = [
    'Title',
    'Date, Time, & Location',
    'Team Member'
  ];
  final List<String> label2 = ['Contact', 'Leads'];
  final List<String> label3 = [
    'Meeting Methods',
    'Notes',
  ];

  late String selected;

//  final MultiSelectController<Contact> controller = MultiSelectController<Contact>();

  // List<DropdownItem<Contact>> items = [];

  @override
  void initState() {
    super.initState();
    selected = '';
    // contactItem();
  }

  // List<DropdownItem<Contact>> contactItem() {
  //   return widget.allContacts.map((contact) {
  //     return DropdownItem<Contact>(
  //       label: '${contact.firstName} ${contact.lastName}',
  //       value: contact,
  //     );
  //   }).toList();
  // }

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
                    pageTitle(AppString.newMeeting),
                    BlocProvider(
                      create: (context) => MeetingBloc(meetingRepository),
                      child: BlocConsumer<MeetingBloc, MeetingState>(
                        listener: (listenerContext, state) {
                          if (state is MeetingError) {
                            showToastError(context, state.message);
                          } else if (state is MeetingLoaded) {
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
                  body: SingleChildScrollView(
                    child: Container(
                      padding: AppTheme.padding10,
                      child: Form(
                        key: _formState,
                        child: Column(
                          children: [
                            inputField(label1[0], controller: titleController),
                            displayInField(context, label1[1],
                                function: () async {
                              final result = await bottomSheet(
                                context,
                                PickDate(
                                  locationController: locationController,
                                  startTime: startTime,
                                  endTime: endTime,
                                ),
                              );

                              if (result != null) {
                                // Update the startTime and endTime with the returned values
                                setState(() {
                                  startTime = result[
                                      'startTime']; // Assign selected startTime
                                  endTime = result[
                                      'endTime']; // Assign selected endTime
                                });
                              }
                            }),
                            multipleDropdown(context, label1[2],
                                controller: userController,
                                items: widget.allUser,
                                getDisplayValue: (user) =>
                                    (user as User).login_id,
                                getStoredValue: (user) => (user as User).id!),
                            multipleDropdown(
                              context,
                              label2[0],
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
                            singleDropdown(context, label2[1],
                                isShow: true,
                                controller: leadController,
                                items: widget.allLeads,
                                getDisplayValue: (lead) =>
                                    (lead as Leads).title,
                                getStoredValue: (lead) => (lead as Leads).id!,
                                buttonFunction: () => addLeads(
                                    context,
                                    widget.contactForms,
                                    widget.allContacts,
                                    widget.allUser,
                                    widget.leadLabel)),
                            singleDropdownWihtoutObject(context, label3[0],
                                items: AppString.methodHolder,
                                controller: methodsController),
                            inputField(label3[1],
                                longInput: true, controller: notesController),
                            const SizedBox(height: 10),
                            followUpHeader(() => bottomSheet(
                                context,
                                AddFollowingAction(
                                  allUser: widget.allUser,
                                  allContact: widget.allContacts,
                                  allLeads: widget.allLeads,
                                  contactForms: widget.contactForms,
                                  leadLabel: widget.leadLabel,
                                ))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 700,
                              child: followUpAction(
                                  context,
                                  widget.taskList,
                                  widget.allContacts,
                                  widget.allUser,
                                  widget.contactForms,
                                  // widget.leadForms,
                                  widget.leadLabel,
                                  shrinkWrap: true),
                            ),
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

      final meetingNote = createMeetingFromForms();
      await sendMeeting(meetingNote);
    } else {
      showToastError(context, 'Form is not valid!');
    }
  }

  MeetingNote createMeetingFromForms() {
    return MeetingNote(
        title: titleController.text,
        start_time: startTime?.toIso8601String() ?? '',
        end_time: endTime?.toIso8601String() ?? '',
        location: locationController.text,
        methods: methodsController.text,
        notes: notesController.text);
  }

  Future<void> sendMeeting(MeetingNote meetingIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final actionBloc = BlocProvider.of<MeetingBloc>(_blocContext!);
    actionBloc.add(CreateMeeting(
        buildContext: context,
        meetingIn: meetingIn,
        participantIds: userController.text.split(','),
        leadId: leadController.text,
        contactIds: contactController.text.split(',')));
  }
}
