// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingNote _$MeetingNoteFromJson(Map<String, dynamic> json) => MeetingNote(
      title: json['title'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      location: json['location'] as String,
      methods: json['methods'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$MeetingNoteToJson(MeetingNote instance) =>
    <String, dynamic>{
      'title': instance.title,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'location': instance.location,
      'methods': instance.methods,
      'notes': instance.notes,
    };
