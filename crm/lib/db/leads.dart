import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';

part 'leads.g.dart';

@JsonSerializable(explicitToJson: true)
class Leads extends ISuspensionBean {
  @JsonKey(ignore: true)
  final String? id;

  final String portfolio;
  final String title;
  final String scope;
  final String client;
  final String end_user;
  final String location;
  final String status;
  // final List<Object> contact_id;
  final double value;

  @JsonKey(ignore: true)
  final String? created_by;

  @JsonKey(ignore: true)
  final String? created_at;

  @JsonKey(ignore: true)
  late final String tag;

  @JsonKey(ignore: true)
  @override
  bool isShowSuspension = false;

  Leads(
      {this.id, // Made nullable
      required this.portfolio,
      required this.title,
      required this.scope,
      required this.client,
      required this.end_user,
      required this.location,
      required this.status,
      // required this.contact_id,
      required this.value,
      this.created_by,
      this.created_at}) {
    tag = title.isNotEmpty ? title[0].toUpperCase() : '#';
  }

  @override
  String getSuspensionTag() => tag;

  Map<String, dynamic> toJson() => _$LeadsToJson(this);

  factory Leads.fromJson(Map<String, dynamic> data) {
    return Leads(
      id: data['id'] as String?,
      portfolio: data['portfolio'] as String,
      title: data['title'] as String,
      scope: data['scope'] as String,
      client: data['client'] as String,
      end_user: data['end_user'] as String,
      location: data['location'] as String,
      status: data['status'] as String,
      // contact_id: data['contact_id'] != null
      //     ? (data['contact_id'] as List<dynamic>)
      //         .map((contactData) =>
      //             Contact.fromJson(contactData as Map<String, dynamic>))
      //         .toList()
      //     : [],
      value: (data['value'] as num).toDouble(),
      created_by: data['created_by'] as String?,
      created_at: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String).toIso8601String()
          : null,
    );
  }

  static List<Leads> fromJsonList(List<dynamic> dataList) {
    return dataList.map((data) => Leads.fromJson(data)).toList();
  }
}
