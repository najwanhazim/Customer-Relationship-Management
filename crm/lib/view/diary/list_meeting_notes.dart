import 'package:flutter/material.dart';

import '../../db/task.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ListMeetingNotes extends StatefulWidget {
  const ListMeetingNotes({super.key});

  @override
  State<ListMeetingNotes> createState() => _ListMeetingNotesState();
}

class _ListMeetingNotesState extends State<ListMeetingNotes> {
  String search = '';

  List<Map<String, String>> today = [
    {'name': 'Naiem', 'noti': 'upload'},
    {'name': 'Azri', 'noti': 'upload'},
    {'name': 'Fern', 'noti': 'follow-up'}
  ];

  List<Map<String, String>> yesterday = [
    {'name': 'Naiem', 'noti': 'register'},
    {'name': 'Azri', 'noti': 'upload meeting'}
  ];

  List<Task> _mapToTask(List<Map<String, String>> data) {
    return data.map((item) {
      return Task(
          id: item['id']!,
          action: item['action']!,
          remarks: item['remarks'],
          status: item['status']!,
          lead_id: item['leadId'],
          contact_id: item['contactId']!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: AppTheme.padding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(context),
              ],
            ),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Meeting Notes',
                style: AppTheme.titleFont,
              ),
            ),
            searchBar(search),
            AppTheme.box10,
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            AppTheme.divider,
            generateMeetingNotes(data: today),
            AppTheme.box30,
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Yesterday',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            AppTheme.divider,
            generateMeetingNotes(data: yesterday),
          ],
        ),
      ),
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

  Widget generateMeetingNotes({required List<Map<String, String>> data}) {
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
          title: Text(data[index]['name']!, style: AppTheme.listTileFont,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data[index]['noti']!),
              Text(data[index]['noti']!),
            ],
          ),
        );
      },
    );
  }
}
