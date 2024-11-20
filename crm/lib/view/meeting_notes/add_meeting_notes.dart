import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_theme_constant.dart';

class AddMeetingNotes extends StatefulWidget {
  const AddMeetingNotes({super.key});

  @override
  State<AddMeetingNotes> createState() => _AddMeetingNotesState();
}

class _AddMeetingNotesState extends State<AddMeetingNotes> {
  final List<String> label1 = [
    'Title',
    'Date, Time, & Location',
  ];
  final List<String> label2 = ['Attendees', 'Leads'];
  final List<String> label3 = [
    'Meeting Methods',
    'Notes',
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
                    cancelButton(context),
                    pageTitle(AppString.newMeeting),
                    saveButton(),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor:
                      Colors.transparent, // Fix for background issue
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    margin: AppTheme.padding8,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                              decoration: InputDecoration(
                                labelText: label1[0],
                                filled: true,
                                fillColor: AppTheme.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                // print('Name entered: $value');
                              }),
                        ),
                        displayInField(context, label1[1], () => pickDateSheet(context)),
                        displayInField(context, label2[0], () => pickDate(),
                            isShow: true),
                        displayInField(context, label2[1], () => pickDate(),
                            isShow: true),
                        displayInField(context, label3[0], () => pickDate()),
                        displayInField(context, label3[1], () => pickDate()),
                        SizedBox(
                          height: 10,
                        ),
                        followUpHeader(),
                        // followUpAction(context)
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

  Future pickDateSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: AppTheme.grey,
        isScrollControlled: true,
        builder: (context) {
          return pickDate();
        });
  }

  Widget pickDate() {

    CalendarFormat calendarFormat = CalendarFormat.month;
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDate;

    return SafeArea(
      child: Container(
        decoration: AppTheme.bottomSheet,
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
                    pageTitle(AppString.date),
                    saveButton(),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2024, 11, 1),
                        lastDay: DateTime.utc(2030, 11, 24),
                        focusedDay: focusedDay,
                        selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                        calendarFormat: calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false
                        ),
                        onFormatChanged: (format) {
                          if(calendarFormat != format){
                            setState(() {
                              calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          focusedDay = focusedDay;
                        },
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
