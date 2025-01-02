part of 'lead_bloc.dart';

@immutable
abstract class LeadEvent extends Equatable {
  const LeadEvent();
}

class CreateLead extends LeadEvent {

  final BuildContext buildContext;
  final Leads leadIn;
  final List<String> contactIds;

  const CreateLead({required this.buildContext, required this.leadIn, required this.contactIds});

  @override
  List<Object> get props => [buildContext, leadIn, contactIds];
}

// class UpdateContact extends ContactEvent{
//   final BuildContext buildContext;
//   final Contact contactIn;
//   final String contactId;

//   const UpdateContact({required this.buildContext, required this.contactIn, required this.contactId});

//   @override
//   List<Object> get props => [buildContext, contactIn, contactId];
// }