// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAction _$TaskActionFromJson(Map<String, dynamic> json) => TaskAction(
      action: json['action'] as String,
      status: json['status'] as String,
      contact_ids: TaskAction._contactIdFromJson(json['contact_ids']),
      lead_id: json['lead_id'] as String,
      remarks: json['remarks'] as String,
    );

Map<String, dynamic> _$TaskActionToJson(TaskAction instance) =>
    <String, dynamic>{
      'action': instance.action,
      'remarks': instance.remarks,
      'status': instance.status,
      'lead_id': instance.lead_id,
      'contact_ids': TaskAction._contactIdToJson(instance.contact_ids),
    };
