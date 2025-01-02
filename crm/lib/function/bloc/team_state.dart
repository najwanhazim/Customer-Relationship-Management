part of 'team_bloc.dart';

@immutable
abstract class TeamState extends Equatable {
  const TeamState();
}

class TeamInitial extends TeamState {
  @override
  List<Object> get props => [];
}

class TeamLoading extends TeamState {
  @override
  List<Object> get props => [];
}

class TeamLoaded extends TeamState {
  final String message;
  // final bool state;

  const TeamLoaded(this.message);
  @override
  List<Object> get props => [message];
}

class TeamFinish extends TeamState {
  final String message;

  const TeamFinish(this.message);
  @override
  List<Object> get props => [message];
}

class TeamError extends TeamState {
  final String message;

  const TeamError(this.message);
  @override
  List<Object> get props => [message];
}
