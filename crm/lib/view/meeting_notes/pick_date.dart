import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class PickDate extends StatefulWidget {
  const PickDate({super.key});

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDaySelected(DateTime _selectedDate, DateTime _focusedDay) {
    if (!isSameDay(selectedDate, _selectedDate)) {
      setState(() {
        selectedDate = _selectedDate;
        focusedDay = _focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center, // Center the title
                        child: pageTitle(AppString.date),
                      ),
                      Align(
                        alignment: Alignment
                            .centerRight, // Align the saveButton to the right
                        child: saveButton(context),
                      ),
                    ],
                  )),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Form(
                      key: _formState,
                      child: Column(
                        children: [
                          TableCalendar(
                            firstDay: DateTime.utc(2024, 11, 1),
                            lastDay: DateTime.utc(2030, 11, 24),
                            focusedDay: focusedDay,
                            selectedDayPredicate: (day) =>
                                isSameDay(selectedDate, day),
                            calendarFormat: calendarFormat,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: onDaySelected,
                            calendarStyle:
                                const CalendarStyle(outsideDaysVisible: false),
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
                          SizedBox(height: 8),
                          AppTheme.divider,
                          Padding(
                            padding: AppTheme.paddingTepi,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppString.startText),
                                timePicker(),
                              ],
                            ),
                          ),
                          AppTheme.divider,
                          Padding(
                            padding: AppTheme.paddingTepi,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppString.endText),
                                timePicker(),
                              ],
                            ),
                          ),
                          AppTheme.divider,
                          Padding(
                            padding: AppTheme.paddingTepi,
                            child: inputField(AppString.locationText)
                          ),
                        ],
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

  Widget timePicker() {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.time,
      initTime: DateTime.now().toLocal(),
      use24hFormat: false,
      timeFormat: 'h:mm a',
      onChange: (dateTime) {},
    );
  }
}
