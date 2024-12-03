import 'dart:core';
import 'dart:ffi';

import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/dashboard/dashboard_team_stats.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';

class DashboardIndividual extends StatefulWidget {
  const DashboardIndividual({super.key});

  @override
  State<DashboardIndividual> createState() => _DashboardIndividualState();
}

class _DashboardIndividualState extends State<DashboardIndividual> {
  String search = '';
  double valueSales = 0;
  double valueLeads = 0;

  @override
  void initState() {
    super.initState();
    valueLeads = calculateProgress(isLead: true);
    valueSales = calculateProgress(isLead: false);
  }

  double calculateProgress({required bool isLead}) {
    if (isLead) {
      double value1 = 80;
      double value2 = 1000;

      return value1 / value2;
    } else {
      double value1 = 650000;
      double value2 = 1000000;

      return value1 / value2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.scrollDelta! > 0) {
              // Scroll downward
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardStats()));
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              searchBar(search),
              dashboard(),
              AppTheme.box10,
              Padding(
                padding:AppTheme.paddingTepi,
                child: const Text(
                  'Goals',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: AppTheme.padding,
                child: Container(
                  padding: AppTheme.padding10,
                  color: AppTheme.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '80',
                        style: TextStyle(fontSize: 35),
                      ),
                      const Text(
                        'Leads',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        color: Colors.green,
                        value: valueLeads,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: AppTheme.padding,
                child: Container(
                  padding: AppTheme.padding10,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'RM 650,000.00',
                        style: TextStyle(fontSize: 35),
                      ),
                      const Text(
                        'Sales Won',
                        style: TextStyle(fontSize: 20),
                      ),
                      AppTheme.box20,
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        color: Colors.green,
                        value: valueSales,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: speedDial(),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
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
    );
  }
}
