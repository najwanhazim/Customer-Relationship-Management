import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  final String title;
  final String location;
  final String medium;
  final String start_time;
  final String end_time;
  final String notes;
  final String contact_id;

  @JsonKey(ignore: true)
  final String? id;

  @JsonKey(ignore: true)
  final String? created_at;

  @JsonKey(ignore: true)
  final String? updated_at;

  @JsonKey(ignore: true)
  final String? created_by;

  @JsonKey(ignore: true)
  final String? updated_by;

  Appointment({
    required this.title,
    required this.location,
    required this.medium,
    required this.start_time,
    required this.end_time,
    required this.notes,
    required this.contact_id,
    this.id,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by
  });

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  factory Appointment.fromJson(Map<String, dynamic> data) {
    return Appointment(
      id: data['id'],
      title: data['title'],
      start_time: data['start_time'] != null
          ? DateTime.parse(data['start_time'] as String).toIso8601String()
          : '',
      end_time: data['end_time'] != null
          ? DateTime.parse(data['end_time'] as String).toIso8601String()
          : '',
      location: data['location'],
      medium: data['medium'],
      notes: data['notes'],
      contact_id: data['contact_id'],
      created_by: data['created_by'],
      created_at: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String).toIso8601String()
          : null,
      updated_at: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'] as String).toIso8601String()
          : null,
      updated_by: data['updated_by']
    );
  }

   static List<Appointment> fromJsonList(List<dynamic> dataList) {
    return dataList.map((data) => Appointment.fromJson(data)).toList();
  }
}