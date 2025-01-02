import 'package:json_annotation/json_annotation.dart';

part 'task_action.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskAction{
  @JsonKey(ignore: true)
  final String? id;

  final String action;
  final String remarks;
  final String status;
  final String lead_id;

  @JsonKey(fromJson: _contactIdFromJson, toJson: _contactIdToJson)
  final List<String> contact_ids; 

  TaskAction({
    this.id,
    required this.action,
    required this.status,
    required this.contact_ids,
    required this.lead_id,
    required this.remarks
  });

  Map<String, dynamic> toJson() => _$TaskActionToJson(this);

  factory TaskAction.fromJson(Map<String, dynamic> json) {
    return TaskAction(
      id: json['id'] as String?,
      action: json['action'] as String,
      status: json['status'] as String,
      // contact_ids: (json['contact_id'] as List<dynamic>)
      //     .map((e) => e as String)
      //     .toList(),
      // contact_id: json['contact_id'] as String,
      contact_ids: TaskAction._contactIdFromJson(json['contact_id']),
      lead_id: json['lead_id'] as String? ?? '',
      remarks: json['remarks'] as String,
    );
  }

  static List<TaskAction> fromJsonList(List<dynamic> dataList) {
    return dataList.map((data) => TaskAction.fromJson(data)).toList();
  }

  static List<String> _contactIdFromJson(dynamic json) {
    if (json is String) {
      // Single string, return as a single-item list
      return [json];
    } else if (json is List<dynamic>) {
      // List of strings, cast to List<String>
      return json.map((e) => e as String).toList();
    } else {
      // Return an empty list if the data is null or unexpected
      return [];
    }
  }

  static dynamic _contactIdToJson(List<String> contactIds) {
    // Convert list to single string if it has only one item, otherwise keep as a list
    return contactIds.length == 1 ? contactIds.first : contactIds;
  }
}