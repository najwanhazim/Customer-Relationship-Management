// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      title: json['title'] as String,
      location: json['location'] as String,
      medium: json['medium'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      notes: json['notes'] as String,
      contact_id: json['contact_id'] as String,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location': instance.location,
      'medium': instance.medium,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'notes': instance.notes,
      'contact_id': instance.contact_id,
    };
