import 'package:crm/db/appointment.dart';
import 'package:crm/function/repository/appointment_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/diary/add_appointment.dart';
import 'package:crm/view/diary/list_meeting_notes.dart';
import 'package:crm/view/diary/task_page.dart';
import 'package:crm/view/diary/view_appointment.dart';
import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../db/contact.dart';
import '../../db/user.dart';
import '../../function/repository/contact_repository.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class DiaryHomePage extends StatefulWidget {
  const DiaryHomePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<DiaryHomePage> createState() => _DiaryHomePageState();
}

class _DiaryHomePageState extends State<DiaryHomePage> {
  String search = '';
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    getAllUser();
    gettAllContact();
    getAppointment();
  }

  final List<FormGroup> contactForms = [
    FormGroup({
      'firstName': FormControl<String>(),
      'lastName': FormControl<String>(),
      'company': FormControl<String>(),
      'position': FormControl<String>(),
    }),
    FormGroup({
      'phoneNumber': FormControl<String>(),
      'email': FormControl<String>(),
    }),
    FormGroup({
      'salutation': FormControl<String>(),
      'contactType': FormControl<String>(),
      'source': FormControl<String>(),
      'remarks': FormControl<String>(),
    }),
  ];

  UserRepository userRepository = UserRepository();
  ContactRepository contactRepository = ContactRepository();
  AppointmentRepository appointmentRepository = AppointmentRepository();

  List<User> userList = [];
  List<Contact> contactList = [];
  List<Appointment> appointmentList = [];
  List<Appointment> filteredAppointments = [];
  Map<DateTime, List<Appointment>> appointmentsByDate = {};

  Future<void> getAllUser() async {
    try {
      userList = await userRepository.getAllUser();
    } catch (e) {
      print(e);
    }
  }

  Future<void> gettAllContact() async {
    try {
      contactList = await contactRepository.getContactByUserId();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAppointment() async {
    try {
      appointmentList = await appointmentRepository.getAppointment();
      groupAppointmentsByDate();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        // filterAppointmentsByDate(selectedDate);
      });
    }
  }

  void groupAppointmentsByDate() {
    appointmentsByDate = {};

    for (var appointment in appointmentList) {
      final appointmentDate = DateTime.parse(appointment.start_time);

      // Use only the date part
      final dateOnly = DateTime(
          appointmentDate.year, appointmentDate.month, appointmentDate.day);

      if (!appointmentsByDate.containsKey(dateOnly)) {
        appointmentsByDate[dateOnly] = [];
      }
      appointmentsByDate[dateOnly]!.add(appointment);
    }
  }

  List<Appointment> getAppointmentsForDate(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return appointmentsByDate[dateOnly] ?? [];
  }

  void onDaySelected(DateTime _selectedDate, DateTime _focusedDay) {
    setState(() {
      if (isSameDay(selectedDate, _selectedDate)) {
        selectedDate = null;
        filteredAppointments = [];
      } else {
        selectedDate = _selectedDate;
        filteredAppointments = getAppointmentsForDate(selectedDate!);
      }
      focusedDay = _focusedDay;
    });
  }

  void filterAppointmentsByDate(DateTime? date) {
    if (date == null) {
      filteredAppointments = [];
      return;
    }
    filteredAppointments = appointmentList.where((appointment) {
      return isSameDay(
        DateTime.parse(
            appointment.start_time), // Convert start_time to DateTime
        date,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: Padding(
        padding: AppTheme.padding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homeButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ListMeetingNotes(), // Correctly return the Task widget
                          ),
                        );
                      },
                      icon: Icon(Icons.folder),
                      color: Colors.grey,
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskPage(), // Correctly return the Task widget
                          ),
                        );
                      },
                      icon: Icon(Icons.menu),
                      color: Colors.grey,
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Diary',
                style: AppTheme.titleFont,
              ),
            ),
            searchBar(search),
            Container(
              decoration: AppTheme.container,
              padding: AppTheme.padding8,
              margin: AppTheme.padding10,
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 11, 1),
                lastDay: DateTime.utc(2030, 11, 24),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                calendarFormat: calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: onDaySelected,
                rowHeight: 40,
                eventLoader: (day) {
                  return getAppointmentsForDate(day);
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  defaultTextStyle: const TextStyle(fontSize: 12),
                  weekendTextStyle:
                      const TextStyle(fontSize: 12, color: Colors.red),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppTheme.redMaroon,
                    shape: BoxShape.circle,
                  ),
                ),
                onFormatChanged: (format) {
                  if (calendarFormat != format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  focusedDay = focusedDay;
                },
              ),
            ),
            Expanded(
              child: Container(
                decoration: AppTheme.container,
                padding: AppTheme.padding8,
                margin: AppTheme.padding10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.appointmentTitle,
                            style: AppTheme.profileFont,
                          ),
                          addButton(() {
                            bottomSheet(
                                context,
                                AddAppointment(
                                  forms: contactForms,
                                  allUsers: userList,
                                  allContacts: contactList,
                                ));
                          })
                        ],
                      ),
                    ),
                    Expanded(child: appointmentGenerator())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }

  Widget appointmentGenerator() {
    if (filteredAppointments == null || filteredAppointments.isEmpty) {
      return const Center(
        child: Text(
          "No appointments on this date",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: filteredAppointments.length,
        itemBuilder: (context, index) {
          final appointment = filteredAppointments[index];

          return ListTile(
            title: Text(
              appointment.title,
              style: AppTheme.listTileFont,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDateTime(appointment.start_time),
                  style: AppTheme.subListTileFont,
                ),
                Text(
                  appointment.location,
                  style: AppTheme.subListTileFont,
                ),
              ],
            ),
            onTap: () {
              bottomSheet(
                  context,
                  ViewAppointment(
                    forms: contactForms,
                    allContacts: contactList,
                    appointment: appointment,
                  ));
            },
          );
        },
      );
    }
  }
}
