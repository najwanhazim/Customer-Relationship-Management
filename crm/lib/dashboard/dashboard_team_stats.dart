import 'package:flutter/material.dart';

import '../utils/app_theme_constant.dart';
import '../utils/app_widget_constant.dart';

class DashboardStats extends StatefulWidget {
  const DashboardStats({super.key});

  @override
  State<DashboardStats> createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  Map<String, double> dataMap = {
    'Suspect': 1,
    'Opportunity': 3,
    'Win': 10,
    'Lost': 5,
    'Disqualified': 2
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.grey,
        appBar: appBarPage(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: AppTheme.padding8,
              child: Text(
                'Hi Naiem,',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            pieChart(context, dataMap, 'Leads', colorList),
            pieChart(context, dataMap, 'Meetings', colorList),
          ],
        ),
        floatingActionButton: speedDial());
  }
}
