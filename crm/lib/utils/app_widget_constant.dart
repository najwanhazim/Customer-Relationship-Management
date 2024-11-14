import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

AppBar appBarPage() {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.red[900],
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
        ),
      ),
      const CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage(
            'https://www.google.com/imgres?q=profile&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F003%2F715%2F527%2Fnon_2x%2Fpicture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Fvector-art%2F3715527-picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector&docid=jV8noe8xdKAwbM&tbnid=3nPRi6_QfknfYM&vet=12ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA'),
      ),
    ],
  );
}

Widget dashboard() {
  return Padding(
    padding: const EdgeInsets.all(
        8.0), // Optional padding around the entire dashboard
    child: Column(
      children: [
        Row(
          children: [
            dashboardContent(
                Colors.purple[100], '5', 'Today Appointment', Icons.groups),
            dashboardContent(
                Colors.pink[50], '3', 'Pending Task', Icons.report),
          ],
        ),
        Row(
          children: [
            dashboardContent(Colors.amber[100], '15', 'Tomorrow appointment',
                Icons.schedule),
            dashboardContent(Colors.green[100], '10', 'This Week Appointment',
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
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(3),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 10),
            Text(
              num,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    ),
  );
}

SpeedDial speedDial() {
  return SpeedDial(
    closedBackgroundColor: Colors.red[900],
    openBackgroundColor: Colors.red[200],
    closedForegroundColor: Colors.white,
    openForegroundColor: Colors.white24,
    speedDialChildren: [
      speedDialChild(Icons.directions_walk, 'New Action'),
      speedDialChild(Icons.event, 'New Meeting'),
      speedDialChild(Icons.folder, 'New Lead'),
      speedDialChild(Icons.account_circle, 'New Contact'),
    ],
    child: const Icon(Icons.add),
  );
}

SpeedDialChild speedDialChild(IconData icon, String label) {
  return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: Colors.red[900],
      foregroundColor: Colors.white,
      label: label,
      onPressed: () {},
      closeSpeedDialOnPressed: false);
}

Widget pieChart(BuildContext context, Map<String, double> dataMap,
    String centerTextTitle, List<Color> colorList) {
  double totalNum = dataMap.values.fold(0.0, (sum, value) => sum + value);

  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
      color: Colors.white,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 800),
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
    padding: const EdgeInsets.all(10),
    child: TextField(
      decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    ),
  );
}