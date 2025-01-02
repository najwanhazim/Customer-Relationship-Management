import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class PickDate extends StatefulWidget {
  PickDate(
      {Key? key,
      required this.locationController,
      this.startTime,
      this.endTime})
      : super(key: key);

  final TextEditingController locationController;
  DateTime? startTime;
  DateTime? endTime;

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
    widget.locationController.dispose();
    super.dispose();
  }

  void onDaySelected(DateTime _selectedDate, DateTime _focusedDay) {
    if (!isSameDay(selectedDate, _selectedDate)) {
      setState(() {
        selectedDate = _selectedDate;
        focusedDay = _focusedDay;
      });
      print("Selected date: $selectedDate");
    }
  }

  // void onDaySelected(DateTime _selectedDate, DateTime _focusedDay) {
  //   setState(() {
  //     selectedDate = _selectedDate; // Update selectedDate
  //     focusedDay = _focusedDay; // Update focusedDay
  //   });
  //   print("Selected date: $_selectedDate");
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: AppTheme.bottomSheet,
        child: SizedBox(
          height: AppTheme.sheetHeight,
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
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              'startTime': widget.startTime,
                              'endTime': widget.endTime,
                            });
                          },
                          child: Text(
                            AppString.saveText,
                            style: TextStyle(
                              color: AppTheme.redMaroon,
                              fontSize: 18,
                            ),
                          ),
                        ),
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
                                timePicker(true),
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
                                timePicker(false),
                              ],
                            ),
                          ),
                          AppTheme.divider,
                          Padding(
                              padding: AppTheme.paddingTepi,
                              child: inputField(AppString.locationText,
                                  controller: widget.locationController)),
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

  Widget timePicker(bool isStartTime) {
    // Determine which time to use based on whether it's start time or end time
    DateTime? selectedTime = isStartTime ? widget.startTime : widget.endTime;

    // Initialize the date with the selected time or current date and time
    DateTime initialDateTime = selectedTime ?? DateTime.now();

    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.time,
      // Initialize with selected start or end time and its respective date
      initTime: DateTime(
        initialDateTime.year,
        initialDateTime.month,
        initialDateTime.day,
        initialDateTime.hour,
        initialDateTime.minute,
      ).toLocal(),
      use24hFormat: false,
      timeFormat: 'h:mm a',
      onChange: (dateTime) {
        setState(() {
          print("${isStartTime ? 'Start' : 'End'}: $dateTime");

          // Combine the selected date with the newly chosen time
          DateTime updatedDateTime = DateTime(
            initialDateTime.year, // Use the current or selected year
            initialDateTime.month, // Use the current or selected month
            initialDateTime.day, // Use the current or selected day
            dateTime.hour, // Update hour
            dateTime.minute, // Update minute
          );

          if (isStartTime) {
            widget.startTime =
                updatedDateTime; // Update start time with selected date and time
          } else {
            widget.endTime =
                updatedDateTime; // Update end time with selected date and time
          }
        });
      },
    );
  }
}
