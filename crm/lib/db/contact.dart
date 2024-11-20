import 'package:azlistview/azlistview.dart';

class Contact extends ISuspensionBean {
  final String firstName;
  final String lastName;
  final String company;
  final String position;
  final String phone;
  final String email;
  final String salutation;
  final String contactType;
  final String? source;
  final String? notes;
  final String tag;

  Contact({required this.firstName, required this.lastName, required this.company, required this.position, required this.phone, required this.email, required this.salutation, required this.contactType, this.source, this.notes, required this.tag});

  @override
  String getSuspensionTag() => tag;
}
