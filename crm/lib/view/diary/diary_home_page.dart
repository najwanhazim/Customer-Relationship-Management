import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/diary/add_appointment.dart';
import 'package:crm/view/diary/list_meeting_notes.dart';
import 'package:crm/view/diary/task_page.dart';
import 'package:crm/view/diary/view_appointment.dart';
import 'package:crm/view/meeting_notes/pick_date.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class DiaryHomePage extends StatefulWidget {
  const DiaryHomePage({super.key});

  @override
  State<DiaryHomePage> createState() => _DiaryHomePageState();
}

class _DiaryHomePageState extends State<DiaryHomePage> {
  String search = '';
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  final List<String> allContact = [
    'Ammar',
    'Azri',
    'Naiem',
    'Din',
    'Najwan',
  ];

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

  void onDaySelected(DateTime _selectedDate, DateTime _focusedDay) {
    setState(() {
      if (isSameDay(selectedDate, _selectedDate)) {
        selectedDate = null;
      } else {
        selectedDate = _selectedDate;
      }
      focusedDay = _focusedDay;
    });
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
                                ListMeetingNotes(), // Correctly return the `Task` widget
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
                                TaskPage(), // Correctly return the `Task` widget
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
                                  allContacts: allContact,
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
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'appointment 1',
              style: AppTheme.listTileFont,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'time',
                  style: AppTheme.subListTileFont,
                ),
                Text(
                  'location',
                  style: AppTheme.subListTileFont,
                )
              ],
            ),
            onTap: () {
              bottomSheet(
                  context,
                  ViewAppointment(
                    forms: contactForms,
                    allContacts: allContact,
                  ));
            },
          );
        });
  }
}
