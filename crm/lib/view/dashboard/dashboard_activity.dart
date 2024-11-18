import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class DashboardActivity extends StatefulWidget {
  const DashboardActivity({super.key});

  @override
  State<DashboardActivity> createState() => _DashboardActivityState();
}

class _DashboardActivityState extends State<DashboardActivity> {
  final List<Map<String, dynamic>> data1 = [
    {
      'name': 'Muhammad Naiem Naqiuddin',
      'meeting': [
        {
          'name': 'Meeting with Smith',
          'time': '9 AM - 10 AM',
          'location': 'Zus Coffee Cyber 10'
        },
        {
          'name': 'Lunch with Ramli',
          'time': '9 AM - 10 AM',
          'location': 'Tamarind Square'
        }
      ]
    },
    {
      'name': 'Muhammad Azri',
      'meeting': [
        {
          'name': 'Company Introduction with Exxon',
          'time': '10 AM - 12 PM',
          'location': 'Exxon Mobile Office'
        }
      ]
    },
  ];

  final List<Map<String, dynamic>> data2 = [
    {
      'name': 'Muhammad Najwan Hazim',
      'meeting': [
        {
          'name': 'Meeting with Fern',
          'time': '9 AM - 10 AM',
          'location': 'Zus Coffee Cyber 10'
        },
        {
          'name': 'Lunch with Raimy',
          'time': '9 AM - 10 AM',
          'location': 'Tamarind Square'
        }
      ]
    },
    {
      'name': 'Muhammad AmmR',
      'meeting': [
        {
          'name': 'Company Introduction with Exxon',
          'time': '10 AM - 12 PM',
          'location': 'Exxon Mobile Office'
        }
      ]
    },
  ];

  int selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: Column(
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
          AppTheme.box10,
          tab(),
          AppTheme.box30,
          Expanded(
            child: AnimatedSwitcher(
              duration: AppTheme.duration500,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: selectedTab == 1
                  ? listMeeting(key: UniqueKey(), data: data1)
                  : listMeeting(key: UniqueKey(), data: data2),
            ),
          )
        ],
      ),
      floatingActionButton: speedDial(),
    );
  }

  Widget tab() {
    return Container(
      margin: AppTheme.paddingTepi,
      child: CustomSlidingSegmentedControl(
        initialValue: selectedTab,
        children: const {1: Text('Today'), 2: Text('Tomorrow')},
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        thumbDecoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        isStretch: true,
        onValueChanged: (value) {
          setState(() {
            selectedTab = value;
          });
        },
      ),
    );
  }

  Widget listMeeting(
      {required Key key, required List<Map<String, dynamic>> data}) {
    return ListView.separated(
      key: key,
      padding: AppTheme.padding8,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            radius: AppTheme.radius15,
            backgroundColor: Colors.blue,
          ),
          title: Text(data[index]['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...data[index]['meeting'].map<Widget>((meeting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(meeting['time']),
                      Text(meeting['location']),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
