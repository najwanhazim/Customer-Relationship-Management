import 'package:crm/db/task_action.dart';
import 'package:crm/function/repository/task_action_repository.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

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

  // final List<Map<String, String>> pending = [
  //   {
  //     'id': '1',
  //     'action': 'scheduling phone call',
  //     'remarks': 'Follow-up on client inquiry',
  //     'status': 'pending',
  //     'leadId': '1001',
  //     'actionId': '501',
  //   },
  //   {
  //     'id': '2',
  //     'action': 'send proposal',
  //     'remarks': 'Draft proposal for upcoming project',
  //     'status': 'pending',
  //     'leadId': '1002',
  //     'actionId': '502',
  //   },
  // ];

  // final List<Map<String, String>> done = [
  //   {
  //     'id': '3',
  //     'action': 'client meeting',
  //     'remarks': 'Discuss project timeline',
  //     'status': 'done',
  //     'leadId': '',
  //     'actionId': '503',
  //   }
  // ];

  TaskActionRepository taskActionRepository = TaskActionRepository();
  List<TaskAction> allTask = [];
  List<TaskAction> selectedAction = [];

  @override
  void initState() {
    super.initState();
    getTask();
    updateTaskList();
  }

  Future<void> getTask() async{
    try {
      allTask = await taskActionRepository.getTaskActionByUser();
      print("allTask: $allTask");
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  void updateTaskList() {
    List<TaskAction> filteredActions = [];

    switch (selectedTab) {
      case 1:
        filteredActions =   allTask
            .where((action) =>
                (action.status == "Pending" ||
                    action.status == "pending"))
            .toList();
        break;
      case 2:
        filteredActions =   allTask
            .where((action) =>
                (action.status == "Done" ||
                    action.status == "done"))
            .toList();
        break;
      default:
        filteredActions = [];
    }

    setState(() {
      selectedAction = filteredActions;
    });
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
                        'Total: ${selectedAction.length}',
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
      itemCount: selectedAction.length,
      itemBuilder: (context, index) {
        TaskAction task = allTask[index];
        return ListTile(
          title: Text(
            task.action,
            style: AppTheme.listTileFont,
          ),
          subtitle: Text(
            task.remarks,
            style: AppTheme.subTitleContainer,
          ),
        );
      },
    );
  }
}
