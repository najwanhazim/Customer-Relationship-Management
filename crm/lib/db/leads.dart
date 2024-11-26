import 'package:azlistview/azlistview.dart';

class Leads extends ISuspensionBean {
  final String id;
  final String portfolio;
  final String title;
  final String scope;
  final String client;
  final String end_user;
  final String location;
  final String status;
  final String contact_id;
  final double value;
  final String created_by;
  final String tag;

  Leads(
      {required this.id,
      required this.portfolio,
      required this.title,
      required this.scope,
      required this.client,
      required this.end_user,
      required this.location,
      required this.status,
      required this.contact_id,
      required this.value,
      required this.created_by,
      required this.tag});

  @override
  String getSuspensionTag() => tag;
}
