import 'package:json_annotation/json_annotation.dart';

part 'meeting.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingNote {
  @JsonKey(ignore: true)
  final String? id;

  final String title;
  final String start_time;
  final String end_time;
  final String location;
  final String methods;
  final String notes;

  @JsonKey(ignore: true)
  final String? created_by;
  @JsonKey(ignore: true)
  final String? created_at;
  @JsonKey(ignore: true)
  final String? updated_at;

  MeetingNote(
      {this.id,
      required this.title,
      required this.start_time,
      required this.end_time,
      required this.location,
      required this.methods,
      required this.notes,
      this.created_by,
      this.created_at,
      this.updated_at});

  Map<String, dynamic> toJson() => _$MeetingNoteToJson(this);

  factory MeetingNote.fromJson(Map<String, dynamic> data) {
    return MeetingNote(
      id: data['id'],
      title: data['title'],
      start_time: data['start_time'] != null
          ? DateTime.parse(data['start_time'] as String).toIso8601String()
          : '',
      end_time: data['end_time'] != null
          ? DateTime.parse(data['end_time'] as String).toIso8601String()
          : '',
      location: data['location'],
      methods: data['methods'],
      notes: data['notes'],
      created_by: data['created_by'],
      created_at: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String).toIso8601String()
          : null,
      updated_at: data['updated_at'],
    );
  }

  static List<MeetingNote> fromJsonList(List<dynamic> dataList) {
    return dataList.map((e) {
      return MeetingNote.fromJson(e);
    }).toList();
  }
}
