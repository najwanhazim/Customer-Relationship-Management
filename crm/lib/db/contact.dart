import 'package:json_annotation/json_annotation.dart';
import 'package:azlistview/azlistview.dart';

part 'contact.g.dart';

@JsonSerializable(explicitToJson: true)
class Contact extends ISuspensionBean {
  @JsonKey(ignore: true)
  final String? id;

  @JsonKey(ignore: true)
  final String? created_by;

  @JsonKey(ignore: true)
  final String? created_at;

  @JsonKey(ignore: true)
  final String? updated_by;
  
  final String fullname;
  final String position;
  final String phone_no;
  final String email;
  final String salutation;
  final String contact_type;
  final String source;

  @JsonKey(ignore: true) // Ignore during serialization/deserialization
  late final String tag;

  @JsonKey(ignore: true)
  @override
  bool isShowSuspension = false;

  Contact({
    this.id,
    this.created_by,
    this.created_at,
    this.updated_by,
    required this.fullname,
    required this.position,
    required this.phone_no,
    required this.email,
    required this.salutation,
    required this.contact_type,
    required this.source,
  }) {
    // Compute tag dynamically based on fullname
    tag = fullname.isNotEmpty ? fullname[0].toUpperCase() : '#';
  }

  @override
  String getSuspensionTag() => tag;

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  /// Custom `fromJson` with dynamic tag computation
  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(
      id: data['id'] as String?,
      created_by: data['created_by'] as String?,
      created_at: data['created_at'] as String?,
      updated_by: data['updated_by'] as String?,
      fullname: data['fullname'] as String,
      position: data['position'] as String,
      phone_no: data['phone_no'] as String,
      email: data['email'] as String,
      salutation: data['salutation'] as String,
      contact_type: data['contact_type'] as String,
      source: data['source'] as String,
    );
  }

  /// Convert a List of JSON to List of Contact
  static List<Contact> fromJsonList(List<dynamic> dataList) {
    return dataList.map((data) => Contact.fromJson(data)).toList();
  }

  /// Empty Contact Constructor
  factory Contact.empty() {
    return Contact(
      id: '',
      fullname: '',
      position: '',
      phone_no: '',
      email: '',
      salutation: '',
      contact_type: '',
      source: '',
    );
  }
}
