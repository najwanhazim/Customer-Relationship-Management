part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentState extends Equatable {
  const AppointmentState();
}

class AppointmentInitial extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoaded extends AppointmentState {
  final String message;

  const AppointmentLoaded(this.message);
  @override
  List<Object> get props => [message];
}

class AppointmentFinish extends AppointmentState {
  final String message;

  const AppointmentFinish(this.message);
  @override
  List<Object> get props => [message];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);
  @override
  List<Object> get props => [message];
}
