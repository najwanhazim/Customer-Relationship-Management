import 'package:crm/utils/app_widget_constant.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> today = [
    {'name': 'Naiem', 'noti': 'upload'},
    {'name': 'Azri', 'noti': 'upload'},
    {'name': 'Fern', 'noti': 'follow-up'}
  ];

  List<Map<String, String>> yesterday = [
    {'name': 'Naiem', 'noti': 'register'},
    {'name': 'Azri', 'noti': 'upload meeting'}
  ];

  List<Map<String, String>> last = [
    {'name': 'Fern', 'noti': 'follow-up'},
    {'name': 'Naiem', 'noti': 'upload'},
    {'name': 'Azri', 'noti': 'upload'},
    {'name': 'Fern', 'noti': 'follow-up'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        leading: backButton(context),
        backgroundColor: AppTheme.grey,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.padding10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                AppTheme.box10,
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                AppTheme.divider,
                listNotification(data: today),
                AppTheme.box30,
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Yesterday',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                AppTheme.divider,
                listNotification(data: yesterday),
                AppTheme.box30,
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Last 7 Days',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                AppTheme.divider,
                listNotification(data: last),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listNotification({required List<Map<String, String>> data}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            radius: AppTheme.radius15,
            backgroundColor: Colors.blue,
          ),
          title: Text(data[index]['name']!),
          subtitle: Text(data[index]['noti']!),
        );
      },
    );
  }
}
