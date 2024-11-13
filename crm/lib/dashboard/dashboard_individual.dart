import 'package:crm/app_bar/app_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class DashboardIndividual extends StatefulWidget {
  const DashboardIndividual({super.key});

  @override
  State<DashboardIndividual> createState() => _DashboardIndividualState();
}

class _DashboardIndividualState extends State<DashboardIndividual> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBarPage(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Hi Naiem,',
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
          ),
          dashboard(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Goals',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '80',
                    style: TextStyle(fontSize: 35),
                  ),
                  Text(
                    'Leads',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'RM 650,000.00',
                    style: TextStyle(fontSize: 35),
                  ),
                  Text(
                    'Sales Won',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: speedDial(),
    );
  }
}

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
    child: Icon(Icons.add),
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
