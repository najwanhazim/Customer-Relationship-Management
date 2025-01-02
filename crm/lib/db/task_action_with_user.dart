class TaskActionWithUser {
  final String id;
  final String task_action_id;
  final String assigned_to;
  final String action;
  final String status;

  TaskActionWithUser(
      {required this.id,
      required this.task_action_id,
      required this.assigned_to,
      required this.action,
      required this.status});

  factory TaskActionWithUser.fromJson(Map<String, dynamic> data) {
    return TaskActionWithUser(
      id: data['id'],
      task_action_id: data['task_action_id'],
      assigned_to: data['assigned_to'],
      action: data['action'],
      status: data['status'],
    );
  }

  static List<TaskActionWithUser> fromJsonList(List<dynamic> dataList) {
    return dataList.map((e) => TaskActionWithUser.fromJson(e)).toList();
  }
}
