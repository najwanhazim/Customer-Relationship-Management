import 'package:crm/utils/app_widget_constant.dart';
import 'package:flutter/material.dart';

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
