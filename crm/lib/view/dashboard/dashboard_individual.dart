import 'package:crm/utils/app_widget_constant.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';

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
          searchBar(search),
          dashboard(),
          AppTheme.box10,
          const Text(
            'Goals',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
            child: Container(
              padding: AppTheme.padding10,
              margin: AppTheme.padding,
              color: AppTheme.white,
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
              padding: AppTheme.padding10,
              margin: AppTheme.padding,
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
                  AppTheme.box20,
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
