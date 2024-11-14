import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

AppBar appBarPage() {
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppTheme.redMaroon,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
        ),
      ),
      const CircleAvatar(
        radius: AppTheme.radius15,
        backgroundImage: NetworkImage(
            'https://www.google.com/imgres?q=profile&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F003%2F715%2F527%2Fnon_2x%2Fpicture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Fvector-art%2F3715527-picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector&docid=jV8noe8xdKAwbM&tbnid=3nPRi6_QfknfYM&vet=12ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA'),
      ),
    ],
  );
}

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
            dashboardContent(AppTheme.amber, '15', AppString.dashboard3,
                Icons.schedule),
            dashboardContent(AppTheme.green, '10', AppString.dashboard4,
                Icons.fast_forward),
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

SpeedDial speedDial() {
  return SpeedDial(
    closedBackgroundColor: AppTheme.redMaroon,
    openBackgroundColor: AppTheme.red,
    closedForegroundColor: AppTheme.white,
    openForegroundColor: Colors.white24,
    speedDialChildren: [
      speedDialChild(Icons.directions_walk, AppString.action),
      speedDialChild(Icons.event, AppString.meeting),
      speedDialChild(Icons.folder, AppString.lead),
      speedDialChild(Icons.account_circle, AppString.contact),
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

Widget inputField(String title) {
  return Padding(
    padding: AppTheme.padding10,
    child: TextField(
      decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: AppTheme.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    ),
  );
}