part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class CreateContact extends ContactEvent {

  final BuildContext buildContext;
  final Contact contactIn;

  const CreateContact({required this.buildContext, required this.contactIn});

  @override
  List<Object> get props => [buildContext, contactIn];
}

class UpdateContact extends ContactEvent{
  final BuildContext buildContext;
  final Contact contactIn;
  final String contactId;

  const UpdateContact({required this.buildContext, required this.contactIn, required this.contactId});

  @override
  List<Object> get props => [buildContext, contactIn, contactId];
}