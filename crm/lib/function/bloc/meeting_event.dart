part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent extends Equatable {
  const MeetingEvent();
}

class CreateMeeting extends MeetingEvent {

  final BuildContext buildContext;
  final MeetingNote meetingIn;
  final List<String>? contactIds;
  final List<String>? participantIds;
  final String? leadId;


  const CreateMeeting({required this.buildContext, required this.meetingIn, this.contactIds, this.participantIds, this.leadId});

  @override
  List<Object> get props => [buildContext, meetingIn];
}