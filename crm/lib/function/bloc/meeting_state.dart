part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState extends Equatable {
  const MeetingState();
}

class MeetingInitial extends MeetingState {
  @override
  List<Object> get props => [];
}

class MeetingLoading extends MeetingState {
  @override
  List<Object> get props => [];
}

class MeetingLoaded extends MeetingState {
  final String message;
  // final bool state;

  const MeetingLoaded(this.message);
  @override
  List<Object> get props => [message];
}

class MeetingFinish extends MeetingState {
  final String message;

  const MeetingFinish(this.message);
  @override
  List<Object> get props => [message];
}

class MeetingError extends MeetingState {
  final String message;

  const MeetingError(this.message);
  @override
  List<Object> get props => [message];
}
