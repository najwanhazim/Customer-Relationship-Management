part of 'action_bloc.dart';

@immutable
abstract class ActionEvent extends Equatable {
  const ActionEvent();
}

class CreateAction extends ActionEvent {

  final BuildContext buildContext;
  final TaskAction actionIn;
  final List<String> participants;

  const CreateAction({required this.buildContext, required this.actionIn, required this.participants});

  @override
  List<Object> get props => [buildContext, actionIn];
}