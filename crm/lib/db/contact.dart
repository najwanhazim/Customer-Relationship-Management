import 'package:azlistview/azlistview.dart';

class Contact extends ISuspensionBean {
  final String name;
  final String role;
  final String tag;

  Contact({required this.name, required this.role, required this.tag});

  @override
  String getSuspensionTag() => tag;
}
