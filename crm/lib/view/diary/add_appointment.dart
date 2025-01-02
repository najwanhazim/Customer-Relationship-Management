import 'package:crm/function/repository/appointment_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../../db/appointment.dart';
import '../../db/contact.dart';
import '../../db/user.dart';
import '../../function/bloc/appointment_bloc.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment(
      {Key? key,
      required this.forms,
      required this.allContacts,
      required this.allUsers})
      : super(key: key);

  final List<FormGroup> forms;
  final List<Contact> allContacts;
  final List<User> allUsers;

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mediumController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedStartTime;
  DateTime? startDateTime;

  DateTime? selectedEndDate;
  DateTime? selectedEndTime;
  DateTime? endDateTime;

  AppointmentRepository appointmentRepository = AppointmentRepository();
  BuildContext? _blocContext;

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
                    pageTitle(AppString.newAppointment),
                    BlocProvider(
                      create: (context) =>
                          AppointmentBloc(appointmentRepository),
                      child: BlocConsumer<AppointmentBloc, AppointmentState>(
                        listener: (listenerContext, state) {
                          if (state is AppointmentError) {
                            showToastError(context, state.message);
                          } else if (state is AppointmentLoaded) {
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
                  backgroundColor: Colors
                      .transparent, // Prevents the Scaffold from overriding the background
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    padding: AppTheme.padding10,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            inputField('Title', controller: titleController),
                            inputField('Location',
                                controller: locationController),
                            singleDropdownWihtoutObject(context, 'Medium',
                                items: AppString.methodHolder,
                                controller: mediumController),
                            AppTheme.box10,
                            pickDateTime(
                              context,
                              'Start',
                              timePicker: timePicker((selectedTime) {
                                setState(() {
                                  selectedStartTime = selectedTime;
                                  startDateTime = DateTime(
                                    selectedStartDate?.year ??
                                        DateTime.now().year,
                                    selectedStartDate?.month ??
                                        DateTime.now().month,
                                    selectedStartDate?.day ??
                                        DateTime.now().day,
                                    selectedStartTime?.hour ?? 0,
                                    selectedStartTime?.minute ?? 0,
                                  );
                                  startTimeController.text =
                                      startDateTime!.toIso8601String();
                                });
                              }),
                              datePicker: datePicker((selectedDate) {
                                setState(() {
                                  selectedStartDate = selectedDate;
                                  startDateTime = DateTime(
                                    selectedStartDate!.year,
                                    selectedStartDate!.month,
                                    selectedStartDate!.day,
                                    selectedStartTime?.hour ?? 0,
                                    selectedStartTime?.minute ?? 0,
                                  );
                                  startTimeController.text =
                                      startDateTime!.toIso8601String();
                                });
                              }),
                            ),
                            pickDateTime(
                              context,
                              'End',
                              timePicker: timePicker((selectedTime) {
                                setState(() {
                                  selectedEndTime = selectedTime;
                                  endDateTime = DateTime(
                                    selectedEndDate?.year ??
                                        DateTime.now().year,
                                    selectedEndDate?.month ??
                                        DateTime.now().month,
                                    selectedEndDate?.day ?? DateTime.now().day,
                                    selectedEndTime?.hour ?? 0,
                                    selectedEndTime?.minute ?? 0,
                                  );
                                  endTimeController.text =
                                      endDateTime!.toIso8601String();
                                });
                              }),
                              datePicker: datePicker((selectedDate) {
                                setState(() {
                                  selectedEndDate = selectedDate;
                                  endDateTime = DateTime(
                                    selectedEndDate!.year,
                                    selectedEndDate!.month,
                                    selectedEndDate!.day,
                                    selectedEndTime?.hour ?? 0,
                                    selectedEndTime?.minute ?? 0,
                                  );
                                  endTimeController.text =
                                      endDateTime!.toIso8601String();
                                });
                              }),
                            ),
                            AppTheme.box10,
                            multipleDropdown(context, 'Person In Charge',
                                controller: userController,
                                items: widget.allUsers,
                                getDisplayValue: (user) =>
                                    (user as User).login_id,
                                getStoredValue: (user) => (user as User).id!),
                            singleDropdown(
                              context,
                              'Contact',
                              controller: contactController,
                              items: widget.allContacts,
                              getDisplayValue: (contact) =>
                                  (contact as Contact).fullname,
                              getStoredValue: (contact) =>
                                  (contact as Contact).id!,
                              isShow: true,
                              buttonFunction: () =>
                                  addContact(context, widget.forms),
                            ),
                            inputField('Notes',
                                longInput: true, controller: notesController)
                          ],
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

  Widget timePicker(Function(DateTime) onTimeChange) {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.time,
      initTime: DateTime.now().toLocal(),
      use24hFormat: false,
      timeFormat: 'h:mm a',
      onChange: (time) {
        onTimeChange(time);
      },
    );
  }

  Widget datePicker(Function(DateTime) onDateChange) {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.date,
      initTime: DateTime.now().toLocal(),
      onChange: (date) {
        onDateChange(date);
      },
    );
  }

  Future<void> onSave() async {
    if (_form.currentState != null && _form.currentState!.validate()) {
      _form.currentState!.save();

      final appointment = createAppointmentFromForms();
      await sendAction(appointment);
    } else {
      showToastError(context, 'Form is not valid!');
    }
  }

  Appointment createAppointmentFromForms() {
    return Appointment(
        title: titleController.text,
        location: locationController.text,
        medium: mediumController.text,
        start_time: startTimeController.text,
        end_time: endTimeController.text,
        contact_id: contactController.text,
        notes: notesController.text);
  }

  Future<void> sendAction(Appointment appointmentIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final actionBloc = BlocProvider.of<AppointmentBloc>(_blocContext!);
    actionBloc.add(CreateAppointment(
        buildContext: context,
        appointmentIn: appointmentIn,
        participantIds: userController.text.split(',')));
  }
}
