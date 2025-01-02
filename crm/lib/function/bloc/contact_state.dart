part of 'contact_bloc.dart';

@immutable
abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactLoading extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactLoaded extends ContactState {
  final String message;
  final bool state;

  const ContactLoaded(this.message, this.state);
  @override
  List<Object> get props => [message, state];
}

class ContactFinish extends ContactState {
  final String message;

  const ContactFinish(this.message);
  @override
  List<Object> get props => [message];
}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);
  @override
  List<Object> get props => [message];
}
