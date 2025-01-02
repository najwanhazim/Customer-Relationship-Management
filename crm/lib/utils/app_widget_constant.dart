import 'package:animations/animations.dart';
import 'package:crm/db/meeting.dart';
import 'package:crm/db/task_action_with_user.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/view/action/view_action.dart';
import 'package:crm/view/leads/add_leads.dart';
import 'package:crm/view/meeting_notes/view_meeting_notes.dart';
import 'package:crm/view/profile/edit_profile.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../db/appointment.dart';
import '../db/contact.dart';
import '../db/task_action.dart';
import '../db/user.dart';
import '../function/repository/meeting_repository.dart';
import '../view/contact/add_contact.dart';
import '../view/contact/view_contact.dart';
import '../view/dashboard/dashboard_individual.dart';
import '../view/dashboard/notification.dart';
import '../view/leads/edit_leads.dart';
import '../view/meeting_notes/add_meeting_notes.dart';
import '../view/team_management.dart/add_team.dart';
import 'custom_icon.dart';

//----------------------------------------button----------------------------------------
Widget cancelButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text(
      AppString.cancelText,
      style: TextStyle(
        color: AppTheme.redMaroon,
        fontSize: 18,
      ),
    ),
  );
}

Widget saveButton(BuildContext context,
    {Future<void> Function()? sendFunction}) {
  return TextButton(
    onPressed: sendFunction != null
        ? () async {
            await sendFunction();
            Navigator.pop(context);
          }
        : null, // Disable button if sendFunction is null
    child: Text(
      AppString.saveText,
      style: TextStyle(
        color: AppTheme.redMaroon,
        fontSize: 18,
      ),
    ),
  );
}

Widget addButton(VoidCallback? function) {
  return TextButton(
      onPressed: function,
      child: Text(
        'Add',
        style: TextStyle(color: AppTheme.redMaroon),
      ));
}

Widget backButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text(
      'Back',
      style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
    ),
  );
}

Widget editButton(BuildContext context, Widget widget) {
  return TextButton(
    onPressed: () {
      bottomSheet(context, widget);
    },
    child: Text(
      AppString.editText,
      style: TextStyle(
        color: AppTheme.redMaroon,
        fontSize: 18,
      ),
    ),
  );
}

Widget homeButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/navigation',
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    },
    child: Text(
      'Home',
      style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
    ),
  );
}

Widget deleteButton(BuildContext context) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            showAppDialog(
                context,
                alertDialog(context, deleteContent, "Delete",
                    "Are you sure you want to delete?"));
          },
          child: Container(
            padding: AppTheme.padding10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
                bottom: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                'Delete',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buttonSubmitSuccess(
    RoundedLoadingButtonController roundedLoadingButtonController,
    String buttonText,
    void Function() onPressed) {
  return buttonSubmit(
      roundedLoadingButtonController, buttonText, onPressed, Colors.green,
      animateOnTap: false);
}

Widget buttonSubmitPrimaryNoAnimate(
    RoundedLoadingButtonController roundedLoadingButtonController,
    String buttonText,
    void Function() onPressed) {
  return buttonSubmit(
      roundedLoadingButtonController, buttonText, onPressed, Colors.blue,
      animateOnTap: false);
}

Widget buttonSubmitSecondaryNoAnimate(
    RoundedLoadingButtonController roundedLoadingButtonController,
    String buttonText,
    void Function() onPressed) {
  return buttonSubmit(
      roundedLoadingButtonController, buttonText, onPressed, Colors.orange,
      animateOnTap: false);
}

Widget buttonSubmit(
    RoundedLoadingButtonController roundedLoadingButtonController,
    String buttonText,
    void Function() onPressed,
    Color buttonColor,
    {bool animateOnTap = true,
    String? iconString}) {
  return RoundedLoadingButton(
    controller: roundedLoadingButtonController,
    color: buttonColor,
    successColor: Colors.green,
    duration: const Duration(seconds: 0),
    // resetDuration: const Duration(seconds: 3),
    // resetAfterDuration: true,
    animateOnTap: animateOnTap,
    onPressed: onPressed,
    child: iconString != null
        ? RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppTheme.double16),
                    child: SvgPicture.asset(iconString,
                        width: AppTheme.sizeIconNav, color: AppTheme.white),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(text: buttonText, style: AppTheme.coloredButtonText)
            ]),
          )
        : Text(buttonText, style: AppTheme.coloredButtonText),
  );
}

void deleteContent() {}

// Widget buttonSubmitPrimary(RoundedLoadingButtonController roundedLoadingButtonController, String buttonText, void Function() onPressed) {
//   return buttonSubmit(roundedLoadingButtonController, buttonText, onPressed, Colors.blue);
// }

// Widget buttonSubmit(RoundedLoadingButtonController roundedLoadingButtonController, String buttonText, void Function() onPressed, Color buttonColor,
//   {bool animateOnTap = true, String? iconString }) {

//   return RoundedLoadingButton(
//     controller: roundedLoadingButtonController,
//     color: buttonColor,
//     successColor: Colors.green,
//     duration: const Duration(seconds: 0),
//     // resetDuration: const Duration(seconds: 3),
//     // resetAfterDuration: true,
//     animateOnTap: animateOnTap,
//     onPressed: onPressed,
//     child: iconString != null ?
//       RichText(text: TextSpan(children: [
//         WidgetSpan(child: Padding(
//           padding: const EdgeInsets.only(right: AppConstant.paddingDouble),
//           child: SvgPicture.asset(iconString, width:AppConstant.sizeIconNav, color: AppTheme.white),
//         ), alignment: PlaceholderAlignment.middle),
//         TextSpan(text:buttonText, style: AppTheme.coloredButtonText)]),
//       ) : Text(buttonText, style: AppTheme.coloredButtonText),
//   );
// }

//----------------------------------------page title----------------------------------------
Widget pageTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
    ),
  );
}

//----------------------------------------app bar----------------------------------------
AppBar appBarPage(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppTheme.redMaroon,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationPage()),
          );
        },
        icon: const Icon(
          Icons.notifications,
        ),
      ),
      GestureDetector(
        onTap: () {
          bottomSheet(context, EditProfile());
        },
        child: CircleAvatar(
          radius: AppTheme.radius15,
          backgroundImage: NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/003/715/527/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg'),
        ),
      ),
    ],
  );
}

AppBar permissionAppBar(String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppTheme.redMaroon,
    title: Text(
      title,
      style: AppTheme.titleFont,
    ),
  );
}

Widget secondAppBar(BuildContext context, VoidCallback function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/navigation',
            (Route<dynamic> route) => false, // Remove all previous routes
          );
        },
        child: Text(
          'Home',
          style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
        ),
      ),
      IconButton(
        onPressed: () {
          function();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) {
          //   return NewContact();
          // }));
        },
        icon: Icon(Icons.add),
        color: AppTheme.redMaroon,
        iconSize: 30,
      ),
    ],
  );
}

// ---------------------------------------- date format ----------------------------------------

String formatDateTime(String dateTime) {
  final date = DateTime.parse(dateTime);
  return DateFormat('dd MMM yyyy - hh:mm a').format(date);
}

//---------------------------------------- dashboard ----------------------------------------
Widget dashboard(List<Appointment> appointmentList, List<TaskAction> taskList) {
  int todayCount = getAppointmentCountForDay(DateTime.now(), appointmentList);
  int tomorrowCount = getAppointmentCountForDay(
      DateTime.now().add(const Duration(days: 1)), appointmentList);
  int weekCount = getAppointmentCountForWeek(appointmentList);
  int pendingTaskCount = getPendingTaskCount(taskList);

  return Padding(
    padding: AppTheme.padding8,
    child: Column(
      children: [
        Row(
          children: [
            dashboardContent(AppTheme.purple, '$todayCount',
                AppString.dashboard1, Icons.groups),
            dashboardContent(AppTheme.pink, '$pendingTaskCount',
                AppString.dashboard2, Icons.report),
          ],
        ),
        Row(
          children: [
            dashboardContent(AppTheme.amber, '$tomorrowCount',
                AppString.dashboard3, Icons.schedule),
            dashboardContent(AppTheme.green, '$weekCount', AppString.dashboard4,
                Icons.fast_forward),
          ],
        ),
      ],
    ),
  );
}

int getAppointmentCountForDay(
    DateTime date, List<Appointment> appointmentList) {
  return appointmentList.where((appointment) {
    DateTime appointmentDate =
        DateTime.parse(appointment.start_time); // Adjust based on your model
    return appointmentDate.year == date.year &&
        appointmentDate.month == date.month &&
        appointmentDate.day == date.day;
  }).length;
}

int getAppointmentCountForWeek(List<Appointment> appointmentList) {
  DateTime today = DateTime.now();
  DateTime weekStart = today.subtract(
      Duration(days: today.weekday - 1)); // Start of the week (Monday)
  DateTime weekEnd =
      weekStart.add(const Duration(days: 6)); // End of the week (Sunday)

  return appointmentList.where((appointment) {
    DateTime appointmentDate =
        DateTime.parse(appointment.start_time); // Adjust based on your model
    return appointmentDate.isAfter(weekStart) &&
        appointmentDate.isBefore(weekEnd.add(const Duration(days: 1)));
  }).length;
}

int getPendingTaskCount(List<TaskAction> taskList) {
  return taskList.where((task) {
    return task.status == 'pending' || task.status == 'Pending';
  }).length; // Adjust 'status' field if different
}

Widget dashboardContent(Color? color, String num, String title, IconData icon) {
  return Expanded(
    child: GestureDetector(
      onTap: () {},
      child: Container(
        padding: AppTheme.padding20,
        margin: AppTheme.padding3,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            AppTheme.box10,
            Text(
              num,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            AppTheme.box10,
            Text(title),
          ],
        ),
      ),
    ),
  );
}

Widget pieChart(BuildContext context, Map<String, double> dataMap,
    String centerTextTitle, List<Color> colorList) {
  double totalNum = dataMap.values.fold(0.0, (sum, value) => sum + value);

  return Expanded(
    child: Container(
      margin: AppTheme.padding15,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
      color: AppTheme.white,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: AppTheme.duration800,
        chartLegendSpacing: 40,
        chartRadius: MediaQuery.of(context).size.width,
        chartType: ChartType.ring,
        colorList: colorList,
        ringStrokeWidth: 30,
        centerWidget: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$totalNum\n',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: centerTextTitle,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: false, showChartValues: false),
        legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            legendShape: BoxShape.rectangle,
            legendTextStyle: TextStyle(fontSize: 15)),
      ),
    ),
  );
}

//----------------------------------------speed dial----------------------------------------
SpeedDial speedDial() {
  return SpeedDial(
    closedBackgroundColor: AppTheme.redMaroon,
    openBackgroundColor: AppTheme.red,
    closedForegroundColor: AppTheme.white,
    openForegroundColor: Colors.white24,
    labelsBackgroundColor: AppTheme.red,
    speedDialChildren: [
      speedDialChild(Icons.directions_walk, AppString.action),
      speedDialChild(Icons.event, AppString.meeting),
      speedDialChild(Icons.folder, AppString.lead),
      speedDialChild(Icons.account_circle, AppString.newContact),
    ],
    child: const Icon(Icons.add),
  );
}

SpeedDialChild speedDialChild(IconData icon, String label) {
  return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: AppTheme.redMaroon,
      foregroundColor: AppTheme.white,
      label: label,
      onPressed: () {},
      closeSpeedDialOnPressed: false);
}

//----------------------------------------Input----------------------------------------
// Widget inputField(String title,
//     {bool longInput = false,
//     bool hintText = false,
//     bool numberInput = false,
//     bool passInput = false}) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 8.0),
//     child: TextField(
//         maxLines: longInput ? null : 1,
//         keyboardType: longInput
//             ? TextInputType.multiline
//             : numberInput
//                 ? TextInputType.number
//                 : passInput
//                     ? TextInputType.visiblePassword
//                     : null,
//         obscureText: passInput,
//         textAlignVertical: longInput ? TextAlignVertical.top : null,
//         decoration: InputDecoration(
//           labelText: hintText ? null : title,
//           labelStyle: TextStyle(color: Colors.black),
//           hintText: hintText ? title : null,
//           hintStyle: TextStyle(color: Colors.grey),
//           filled: true,
//           fillColor: AppTheme.white,
//           alignLabelWithHint: true,
//           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(10),
//               bottom: Radius.circular(10),
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(10),
//               bottom: Radius.circular(10),
//             ),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         onChanged: (value) {
//           // print('Name entered: $value');
//         }),
//   );
// }

Widget inputField(String title,
    {TextEditingController? controller,
    bool longInput = false,
    bool hintText = false,
    bool numberInput = false,
    bool passInput = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: TextField(
        controller: controller,
        maxLines: longInput ? null : 1,
        keyboardType: longInput
            ? TextInputType.multiline
            : numberInput
                ? TextInputType.number
                : passInput
                    ? TextInputType.visiblePassword
                    : null,
        obscureText: passInput,
        textAlignVertical: longInput ? TextAlignVertical.top : null,
        decoration: InputDecoration(
          labelText: hintText ? null : title,
          labelStyle: TextStyle(color: Colors.black),
          hintText: hintText ? title : null,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppTheme.white,
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
  );
}

Widget reactiveForm(BuildContext context, FormGroup _form, List<dynamic> label,
    {bool hintText = false}) {
  return ReactiveForm(
    formGroup: _form,
    child: Padding(
      padding: AppTheme.padding10,
      child: Column(
        children: [
          ..._form.controls.keys.map((controlName) {
            int index = _form.controls.keys.toList().indexOf(controlName);
            return reactiveTextField(
                context, controlName, label[index], hintText);
          }).toList(),
        ],
      ),
    ),
  );
}

Widget reactiveTextField(
    BuildContext context, String controlName, String label, bool hintText) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: ReactiveTextField<dynamic>(
      key: Key(controlName),
      formControlName: controlName,
      decoration: InputDecoration(
        labelText: hintText ? null : label,
        hintText: hintText ? label : null,
        filled: true,
        fillColor: AppTheme.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
    ),
  );
}

Widget displayInField(
  BuildContext context,
  String? label, {
  bool isShow = false,
  VoidCallback? function,
  VoidCallback? buttonFunction,
}) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: GestureDetector(
      onTap: function != null ? () => function() : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
            bottom: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text(
                label ?? '',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            isShow ? addButton(buttonFunction) : const SizedBox.shrink(),
          ],
        ),
      ),
    ),
  );
}

Widget pickDateTime(BuildContext context, String? label,
    {Widget? timePicker, Widget? datePicker}) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Text(
              label ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: timePicker,
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: datePicker,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget multipleDropdown(BuildContext context, String labelText,
    {bool isShow = false,
    VoidCallback? buttonFunction,
    required List<Object> items,
    required TextEditingController controller,
    required String Function(Object) getDisplayValue,
    required String Function(Object) getStoredValue}) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownSearch<String>.multiSelection(
              mode: Mode.MENU,
              showSelectedItems: true,
              showSearchBox: true,
              dropdownButtonProps:
                  const IconButtonProps(icon: SizedBox.shrink()),
              items: items.map(getDisplayValue).toList(),
              selectedItems: controller.text.isNotEmpty
                  ? controller.text
                      .split(',')
                      .map((storedValue) {
                        final item = items.cast<Object?>().firstWhere(
                              (item) =>
                                  item != null &&
                                  getStoredValue(item) == storedValue,
                              orElse: () => null, // Explicitly return `null`
                            );
                        return item != null ? getDisplayValue(item) : null;
                      })
                      .whereType<String>() // Filter out null values
                      .toList()
                  : [],
              onChanged: (List<String> selected) {
                final selectedStoredValues = selected
                    .map((displayValue) {
                      final item = items.cast<Object?>().firstWhere(
                            (item) =>
                                item != null &&
                                getDisplayValue(item) == displayValue,
                            orElse: () => null, // Explicitly return `null`
                          );
                      return item != null ? getStoredValue(item) : null;
                    })
                    .whereType<String>() // Filter out null values
                    .toList();
                controller.text =
                    selectedStoredValues.join(','); // Update controller
                print("selected item: ${controller.text}");
              },
              dropdownSearchDecoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
          isShow ? addButton(buttonFunction) : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

Widget singleDropdown(BuildContext context, String labelText,
    {bool isShow = false,
    VoidCallback? buttonFunction,
    required List<Object> items,
    required TextEditingController controller,
    required String Function(Object) getDisplayValue,
    required String Function(Object) getStoredValue}) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              showSearchBox: true,
              items: items.map(getDisplayValue).toList(),
              selectedItem: controller.text.isNotEmpty
                  ? items
                      .cast<Object?>()
                      .map((item) => item != null &&
                              getStoredValue(item) == controller.text
                          ? getDisplayValue(item)
                          : null)
                      .firstWhere((value) => value != null, orElse: () => null)
                  : null,
              onChanged: (String? selected) {
                if (selected != null) {
                  final selectedItem = items.cast<Object?>().firstWhere(
                        (item) =>
                            item != null && getDisplayValue(item) == selected,
                        orElse: () => null, // Explicitly return `null`
                      );
                  if (selectedItem != null) {
                    controller.text = getStoredValue(selectedItem);
                    print("Selected item: ${controller.text}");
                  }
                }
              },
              dropdownSearchDecoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
          isShow ? addButton(buttonFunction) : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

Widget singleDropdownWihtoutObject(BuildContext context, String labelText,
    {bool isShow = false,
    VoidCallback? buttonFunction,
    required List<String> items,
    required TextEditingController controller}) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: items,
              selectedItem: controller.text.isNotEmpty ? controller.text : null,
              onChanged: (String? value) {
                // Update the controller when the user selects a value
                if (value != null) {
                  controller.text = value;
                  print("selected status: ${controller.text}");
                }
              },
              dropdownSearchDecoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
          isShow ? addButton(buttonFunction) : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

//----------------------------------------meeting----------------------------------------
// Widget meetingHistory(
//     BuildContext context,
//     List<String> allContacts,
//     List<String> allTeam,
//     List<FormGroup> contactForms,
//     FormGroup leadForms,
//     List<String> leadLabel) {
//   List<Map<String, String>> data = [
//     {'date': '15th October 2024', 'detail': 'Some details about the meeting.'},
//     {'date': '16th October 2024', 'detail': 'Another meeting detail.'},
//   ];

//   return SizedBox(
//     height: 150,
//     child: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(data[index]['date']!),
//             subtitle: Text(data[index]['detail']!),
//             onTap: () {
//               bottomSheet(
//                   context,
//                   ViewMeetingNotes(
//                     meetingData: data[index],
//                     allContacts: allContacts,
//                     allTeam: allTeam,
//                     contactForms: contactForms,
//                     leadForms: leadForms,
//                     leadLabel: leadLabel,
//                   ));
//             },
//           );
//         }),
//   );
// }

Widget meetingHistory(
    BuildContext context,
    List<MeetingNote> meetingList,
    List<Contact> allContacts,
    List<User> allUser,
    List<FormGroup> contactForms,
    // FormGroup leadForms,
    List<String> leadLabel) {
  final double itemHeight = 80.0;

  final outerListChildren = <SliverList>[
    SliverList(
      delegate: SliverChildBuilderDelegate(childCount: meetingList.length,
          (context, index) {
        return ListTile(
          title: Text(meetingList[index].title),
          subtitle: Text(formatDateTime(meetingList[index].start_time)),
          onTap: () async {
            bottomSheet(
                context,
                ViewMeetingNotes(
                  meetingData: meetingList[index],
                  allContacts: allContacts,
                  allUser: allUser,
                  contactForms: contactForms,
                  // leadForms: leadForms,
                  leadLabel: leadLabel,
                ));
          },
        );
      }),
    )
  ];

  if (meetingList == [] || meetingList.isEmpty) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Text("No Meeting Notes"),
      ),
    );
  } else {
    return SizedBox(
      height: meetingList.length < 3 ? meetingList.length * itemHeight : 200,
      child: CustomScrollView(slivers: outerListChildren),
    );
  }
}

Widget meetingHeader(VoidCallback function) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppString.meetingHistory,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        addButton(function)
      ],
    ),
  );
}

//----------------------------------------follow up action----------------------------------------
// Widget followUpAction(
//     BuildContext context,
//     List<String> allContacts,
//     List<String> allTeam,
//     List<FormGroup> contactForms,
//     FormGroup leadForms,
//     List<String> leadLabel,
//     {bool shrinkWrap = false}) {
//   List<Map<String, String>> data = [
//     {'detail': 'phone call by azri', 'status': 'Pending'},
//     {'detail': 'phone call by azri', 'status': 'Pending'},
//     {'detail': 'phone call by azri', 'status': 'Pending'},
//     {'detail': 'phone call by azri', 'status': 'Done'},
//     {'detail': 'phone call by azri', 'status': 'Pending'},
//     {'detail': 'phone call by azri', 'status': 'pending'},
//   ];

//   return ListView.builder(
//       // physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: shrinkWrap,
//       // primary: false,
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: AppTheme.padding3,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           child: ListTile(
//             title: Text(data[index]['detail']!),
//             trailing: Text(data[index]['status']!,
//                 style: TextStyle(
//                     color: data[index]['status']! == 'pending' ||
//                             data[index]['status']! == 'Pending'
//                         ? Colors.red
//                         : Colors.green)),
//             onTap: () {
//               bottomSheet(
//                   context,
//                   ViewAction(
//                       allTeam: allTeam,
//                       allContact: allContacts,
//                       contactForms: contactForms,
//                       leadForms: leadForms,
//                       leadLabel: leadLabel));
//             },
//           ),
//         );
//       });
// }

Widget followUpAction(
    BuildContext context,
    // String contactName,
    List<TaskActionWithUser> taskList,
    List<Contact> allContacts,
    List<User> allUser,
    List<FormGroup> contactForms,
    // FormGroup leadForms,
    List<String> leadLabel,
    {bool shrinkWrap = false}) {
  String getFirstAndLastName(String fullName) {
    List<String> nameParts = fullName.trim().split(" ");

    // Ensure there are at least two parts in the name
    if (nameParts.length >= 2) {
      return "${nameParts.first} ${nameParts.last}";
    }

    return fullName;
  }

  final outerListChildren = <SliverList>[
    SliverList(
      delegate: SliverChildBuilderDelegate(childCount: taskList.length,
          (context, index) {
        return Container(
          margin: AppTheme.padding3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            title: Text(
                "${taskList[index].action} by ${getFirstAndLastName(taskList[index].assigned_to)}"),
            trailing: Text(taskList[index].status,
                style: TextStyle(
                    color: taskList[index].status == 'pending' ||
                            taskList[index].status == 'Pending'
                        ? Colors.red
                        : Colors.green)),
            onTap: () {
              bottomSheet(
                  context,
                  ViewAction(
                      taskData: taskList[index],
                      // contactName: contactName,
                      allUser: allUser,
                      allContact: allContacts,
                      contactForms: contactForms,
                      // leadForms: leadForms,
                      leadLabel: leadLabel));
            },
          ),
        );
      }),
    )
  ];

  if (taskList == [] || taskList.isEmpty) {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Text("No follow up action"),
      ),
    );
  } else {
    return CustomScrollView(
      slivers: outerListChildren,
    );
  }
}

Widget followUpHeader(VoidCallback function) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppString.followUpText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        addButton(function)
      ],
    ),
  );
}

//----------------------------------------contact----------------------------------------
Future addContact(BuildContext context, List<FormGroup> forms) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    backgroundColor: AppTheme.grey,
    isScrollControlled: true,
    builder: (context) {
      return AddContact(forms: forms);
    },
  );
}

Future viewContact(BuildContext context, Contact contact, List<FormGroup> forms,
    List<String> leadLabel) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return ViewContact(
          contact: contact,
          contactForms: forms,
          // leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

Widget attendeesGenerator(List<Contact> contacts) {
  if (contacts == [] || contacts.isEmpty) {
    return const Center(
      child: Text("No contact or user"),
    );
  } else {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: AppTheme.radius30,
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 5), // Space between avatar and text
              Text(
                extractMiddleName(contact.fullname),
              ),
            ],
          ),
        );
      },
    );
  }
}

String extractMiddleName(String fullname) {
  // Split the fullname by spaces
  final parts = fullname.trim().split(' ');

  // If there is only one part, return it (first name)
  if (parts.length == 1) {
    return parts[0];
  }

  // If there are only two parts, no middle name exists, return the first name
  if (parts.length == 2) {
    return parts[0];
  }

  // Return the middle parts joined (handles multiple middle names)
  return parts.sublist(1, parts.length - 1).join(' ');
}

//----------------------------------------leads----------------------------------------
Future addLeads(BuildContext context, List<FormGroup> forms,
    List<Contact> contacts, List<User> users, List<String> leadLabel) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return AddLeads(
          contactForms: forms,
          allContacts: contacts,
          allUsers: users,
          // leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

Future editLeads(BuildContext context, List<FormGroup> forms,
    List<Contact> contacts, List<String> leadLabel) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return EditLeads(
          contactForms: forms,
          allContacts: contacts,
          // leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

//----------------------------------------team management----------------------------------------
Future addTeam(BuildContext context, List<User> userList) async {
  try {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: AppTheme.grey,
        isScrollControlled: true,
        builder: (context) {
          return AddTeam(userList: userList);
        });
  } catch (e) {
    print("Error showing modal: $e");
  }
}

//----------------------------------------bottom sheet----------------------------------------
Future bottomSheet(BuildContext context, Widget widget) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      });
}

//----------------------------------------loading----------------------------------------
Widget placeholderText({double width = double.infinity}) {
  return Shimmer.fromColors(
    baseColor: AppTheme.shimmerBase,
    highlightColor: AppTheme.shimmerHighlight,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(4)),
      height: AppTheme.shimmerTitle,
      width: width,
    ),
  );
}

//----------------------------------------dialog----------------------------------------
Future showAppDialog(BuildContext context, Widget targetDialog,
    {bool barrierDismissible = false}) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (context, primaryAnimation, secondaryAnimation) =>
          targetDialog,
      transitionBuilder:
          (context, primaryAnimation, secondaryAnimation, child) =>
              FadeScaleTransition(animation: primaryAnimation, child: child),
      barrierDismissible: barrierDismissible,
      barrierLabel: "Dialog");
}

Widget alertDialog(
    BuildContext context, VoidCallback action, String title, String subText,
    {String warningMessage = '', Future<void> Function()? futureAction}) {
  return AlertDialog(
      title: (() {
        if (warningMessage.isNotEmpty) {
          return alertDialogTitleIcon(title);
        } else {
          return Text(title, style: AppTheme.titlePrimary);
        }
      }()),
      content: warningMessage.isEmpty
          ? Text(subText, style: AppTheme.dialogText)
          : alertDialogSubTextWarning(subText, warningMessage),
      elevation: AppTheme.dialogElevation,
      shape: AppTheme.roundedRectangleBorder,
      actions: [
        TextButton(
          child: Text("Cancel",
              style: AppTheme.buttonAcceptCustom(color: Colors.blue)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            onPressed: () async {
              if (futureAction != null) {
                await futureAction();
              }
              action();
            },
            child: Text("Confirm",
                style: AppTheme.buttonAcceptCustom(color: Colors.red))),
      ]);
}

Widget dialogTitleIcon(String title, String iconString, Color iconColor) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: AppTheme.double12),
        child: SvgPicture.asset(iconString,
            width: AppTheme.sizeIconInline, color: iconColor),
      ),
      Expanded(child: Text(title, style: AppTheme.titlePrimary)),
    ],
  );
}

Widget alertDialogSubTextWarning(String subText, String warningMessage) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(subText, textAlign: TextAlign.start, style: AppTheme.dialogText),
      const SizedBox(height: AppTheme.dialogTextGap),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: dividerRounded(),
      ),
      Text(warningMessage,
          textAlign: TextAlign.start, style: AppTheme.dialogSubTitleTextWarning)
    ],
  );
}

Widget alertDialogTitleIcon(String title) {
  return dialogTitleIcon(title, AppString.iconWarning, Colors.red);
}

void showToastError(BuildContext context, String text) {
  // showToast(context, text, Colors.redAccent, AppTheme.toastTextError);
  context.showErrorBar(
    icon: const Icon(FlashBarIcons.failed),
    content: Text(text,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        style: AppTheme.toastTextMisc),
  );
}

void showToastSuccess(BuildContext context, String text) {
  // showToast(context, text, Colors.greenAccent, AppTheme.toastTextSuccess);
  context.showSuccessBar(
    icon: const Icon(FlashBarIcons.pass),
    content: Text(text,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        style: AppTheme.toastTextMisc),
  );
}

//----------------------------------------transition----------------------------------------
class CustomPageRouteBuilder extends PageRouteBuilder {
  Widget targetScreen;
  RoutePageBuilder routePageBuilder;
  RouteTransitionsBuilder routeTransitionsBuilder;

  CustomPageRouteBuilder({
    required this.targetScreen,
    required this.routePageBuilder,
    required this.routeTransitionsBuilder,
    bool fullscreenDialog = false,
  }) : super(
            pageBuilder: routePageBuilder,
            transitionsBuilder: routeTransitionsBuilder,
            fullscreenDialog: fullscreenDialog);
}

CustomPageRouteBuilder pageTransitionFadeThrough(Widget targetScreen,
    {bool fullScreenDialog = false}) {
  return CustomPageRouteBuilder(
    targetScreen: targetScreen,
    fullscreenDialog: fullScreenDialog,
    routePageBuilder: (context, primaryAnimation, secondaryAnimation) =>
        targetScreen,
    routeTransitionsBuilder:
        (context, primaryAnimation, secondaryAnimation, child) =>
            FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child),
  );
}

//-------------------------------------------divider----------------------------------------
Widget dividerRounded() {
  return Container(
    height: 2,
    decoration: const BoxDecoration(
      color: AppTheme.notWhite,
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );
}
