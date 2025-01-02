part of 'action_bloc.dart';

@immutable
abstract class ActionState extends Equatable {
  const ActionState();
}

class ActionInitial extends ActionState {
  @override
  List<Object> get props => [];
}

class ActionLoading extends ActionState {
  @override
  List<Object> get props => [];
}

class ActionLoaded extends ActionState {
  final String message;
  // final bool state;

  const ActionLoaded(this.message);
  @override
  List<Object> get props => [message];
}

class ActionFinish extends ActionState {
  final String message;

  const ActionFinish(this.message);
  @override
  List<Object> get props => [message];
}

class ActionError extends ActionState {
  final String message;

  const ActionError(this.message);
  @override
  List<Object> get props => [message];
}
