part of 'team_bloc.dart';

@immutable
abstract class TeamEvent extends Equatable {
  const TeamEvent();
}

class CreateTeam extends TeamEvent {

  final BuildContext buildContext;
  final List<String> participantIds;

  const CreateTeam({required this.buildContext, required this.participantIds});

  @override
  List<Object> get props => [buildContext, participantIds];
}

class Unassigned extends TeamEvent {

  final BuildContext buildContext;
  final String userId;

  const Unassigned({required this.buildContext, required this.userId});

  @override
  List<Object> get props => [buildContext, userId];
}