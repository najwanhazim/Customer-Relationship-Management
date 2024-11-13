import 'package:crm/dashboard/dashboard_individual.dart';
import 'package:flutter/material.dart';

class DashboardStats extends StatefulWidget {
  const DashboardStats({super.key});

  @override
  State<DashboardStats> createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: appBarPage(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hi Naiem,',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        floatingActionButton: speedDial()
        );
  }
}

Widget pieChart () {
  return Container();
}
