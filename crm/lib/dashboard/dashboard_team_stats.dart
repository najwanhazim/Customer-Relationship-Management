import 'package:crm/dashboard/dashboard_individual.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
            pieChart(context, dataMap, 'Leads', colorList),
            pieChart(context, dataMap, 'Meetings', colorList),
          ],
        ),
        floatingActionButton: speedDial());
  }
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
