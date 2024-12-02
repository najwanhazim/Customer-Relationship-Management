import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../db/task.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String search = '';
  int selectedTab = 1;

  final List<Map<String, String>> pending = [
    {
      'id': '1',
      'action': 'scheduling phone call',
      'remarks': 'Follow-up on client inquiry',
      'status': 'pending',
      'leadId': '1001',
      'contactId': '501',
    },
    {
      'id': '2',
      'action': 'send proposal',
      'remarks': 'Draft proposal for upcoming project',
      'status': 'pending',
      'leadId': '1002',
      'contactId': '502',
    },
  ];

  final List<Map<String, String>> done = [
    {
      'id': '3',
      'action': 'client meeting',
      'remarks': 'Discuss project timeline',
      'status': 'done',
      'leadId': '',
      'contactId': '503',
    }
  ];

  List<Task> allTask = [];

  @override
  void initState() {
    super.initState();
    updateTaskList();
  }

  void updateTaskList() {
    List<Map<String, String>> selectedData;

    switch (selectedTab) {
      case 1:
        selectedData = pending;
        break;
      case 2:
        selectedData = done;
        break;
      default:
        selectedData = [];
    }

    setState(() {
      allTask = _mapToTask(selectedData);
    });
  }

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
                'Task',
                style: AppTheme.titleFont,
              ),
            ),
            searchBar(search),
            tab(),
            Expanded(
              // Use Expanded here to constrain the task list
              child: Container(
                margin: AppTheme.padding10,
                decoration: AppTheme.container,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Total:',
                        style: AppTheme.titleContainer,
                      ),
                    ),
                    const SizedBox(height: 10), // Optional spacing
                    Expanded(
                        child:
                            generateTask()), // ListView is wrapped in Expanded
                  ],
                ),
              ),
            ),
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

  Widget tab() {
    return Container(
      margin: AppTheme.padding10,
      child: CustomSlidingSegmentedControl(
        initialValue: selectedTab,
        children: {
          1: Text(
            'Pending',
            style: TextStyle(
                color: selectedTab == 1 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          2: Text(
            'Done',
            style: TextStyle(
                color: selectedTab == 2 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        },
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
          updateTaskList();
        },
      ),
    );
  }

  Widget generateTask() {
    return ListView.builder(
      itemCount: allTask.length,
      itemBuilder: (context, index) {
        Task task = allTask[index];
        return ListTile(
          title: Text(
            task.action,
            style: AppTheme.listTileFont,
          ),
          subtitle: Text(
            task.contact_id,
            style: AppTheme.subTitleContainer,
          ),
        );
      },
    );
  }
}
