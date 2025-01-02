part of 'lead_bloc.dart';

@immutable
abstract class LeadState extends Equatable {
  const LeadState();
}

class LeadInitial extends LeadState {
  @override
  List<Object> get props => [];
}

class LeadLoading extends LeadState {
  @override
  List<Object> get props => [];
}

class LeadLoaded extends LeadState {
  final String message;
  final bool state;

  const LeadLoaded(this.message, this.state);
  @override
  List<Object> get props => [message, state];
}

class LeadFinish extends LeadState {
  final String message;

  const LeadFinish(this.message);
  @override
  List<Object> get props => [message];
}

class LeadError extends LeadState {
  final String message;

  const LeadError(this.message);
  @override
  List<Object> get props => [message];
}
