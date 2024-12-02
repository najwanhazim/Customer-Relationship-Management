class Task {
  String id;
  String action;
  String? remarks;
  String status;
  String? lead_id;
  String contact_id;

  Task({required this.id, required this.action, this.remarks, required this.status, this.lead_id, required this.contact_id, });
}