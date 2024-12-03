import 'package:animations/animations.dart';
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
import 'package:pie_chart/pie_chart.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../db/contact.dart';
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

Widget saveButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
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

//----------------------------------------dashboard----------------------------------------
Widget dashboard() {
  return Padding(
    padding: AppTheme.padding8,
    child: Column(
      children: [
        Row(
          children: [
            dashboardContent(
                AppTheme.purple, '5', AppString.dashboard1, Icons.groups),
            dashboardContent(
                AppTheme.pink, '3', AppString.dashboard2, Icons.report),
          ],
        ),
        Row(
          children: [
            dashboardContent(
                AppTheme.amber, '15', AppString.dashboard3, Icons.schedule),
            dashboardContent(
                AppTheme.green, '10', AppString.dashboard4, Icons.fast_forward),
          ],
        ),
      ],
    ),
  );
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
Widget inputField(String title,
    {bool longInput = false, bool hintText = false, bool numberInput = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: TextField(
        maxLines: longInput ? null : 1,
        keyboardType: longInput
            ? TextInputType.multiline
            : numberInput
                ? TextInputType.number
                : null,
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
    BuildContext context, String data, String label, bool hintText) {
  return Padding(
    padding: AppTheme.paddingTop,
    child: ReactiveTextField<dynamic>(
      key: Key(data),
      formControlName: data,
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
    required List<String> items}) {
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
              items: items,
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
    {bool isShow = false, VoidCallback? buttonFunction}) {
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
              dropdownButtonProps:
                  const IconButtonProps(icon: SizedBox.shrink()),
              items: const [
                'Ammar',
                'Azri',
                'Naiem',
                'Din',
                'Najwan',
              ],
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
Widget meetingHistory(
    BuildContext context,
    List<String> allContacts,
    List<String> allTeam,
    List<FormGroup> contactForms,
    FormGroup leadForms,
    List<String> leadLabel) {
  List<Map<String, String>> data = [
    {'date': '15th October 2024', 'detail': 'Some details about the meeting.'},
    {'date': '16th October 2024', 'detail': 'Another meeting detail.'},
  ];

  return SizedBox(
    height: 150,
    child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['date']!),
            subtitle: Text(data[index]['detail']!),
            onTap: () {
              bottomSheet(
                  context,
                  ViewMeetingNotes(
                    meetingData: data[index],
                    allContacts: allContacts,
                    allTeam: allTeam,
                    contactForms: contactForms,
                    leadForms: leadForms,
                    leadLabel: leadLabel,
                  ));
            },
          );
        }),
  );
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
Widget followUpAction(
    BuildContext context,
    List<String> allContacts,
    List<String> allTeam,
    List<FormGroup> contactForms,
    FormGroup leadForms,
    List<String> leadLabel,
    {bool shrinkWrap = false}) {
  List<Map<String, String>> data = [
    {'detail': 'phone call by azri', 'status': 'Pending'},
    {'detail': 'phone call by azri', 'status': 'Pending'},
    {'detail': 'phone call by azri', 'status': 'Pending'},
    {'detail': 'phone call by azri', 'status': 'Done'},
    {'detail': 'phone call by azri', 'status': 'Pending'},
    {'detail': 'phone call by azri', 'status': 'pending'},
  ];

  return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      // primary: false,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          margin: AppTheme.padding3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            title: Text(data[index]['detail']!),
            trailing: Text(data[index]['status']!,
                style: TextStyle(
                    color: data[index]['status']! == 'pending' ||
                            data[index]['status']! == 'Pending'
                        ? Colors.red
                        : Colors.green)),
            onTap: () {
              bottomSheet(
                  context,
                  ViewAction(
                      allTeam: allTeam,
                      allContact: allContacts,
                      contactForms: contactForms,
                      leadForms: leadForms,
                      leadLabel: leadLabel));
            },
          ),
        );
      });
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
    FormGroup leadForms, List<String> leadLabel) {
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
          leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

Widget attendeesGenerator() {
  return ListView.builder(
    scrollDirection: Axis.horizontal, // Enable horizontal scrolling
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: AppTheme.radius30,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 5), // Space between avatar and text
            Text('Aiman'),
          ],
        ),
      );
    },
  );
}

//----------------------------------------leads----------------------------------------
Future addLeads(BuildContext context, List<FormGroup> forms,
    List<String> contacts, List<String> leadLabel, FormGroup leadForms) {
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
          leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

Future editLeads(BuildContext context, List<FormGroup> forms,
    List<String> contacts, List<String> leadLabel, FormGroup leadForms) {
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
          leadForms: leadForms,
          leadLabel: leadLabel,
        );
      });
}

//----------------------------------------team management----------------------------------------
Future addTeam(BuildContext context) async {
  print('opening add team');
  try {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: AppTheme.grey,
        isScrollControlled: true,
        builder: (context) {
          return AddTeam();
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
        padding: const EdgeInsets.only(right: AppTheme.paddingGridDouble),
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
