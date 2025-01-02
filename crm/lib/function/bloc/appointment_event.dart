part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();
}

class CreateAppointment extends AppointmentEvent {

  final BuildContext buildContext;
  final Appointment appointmentIn;
  final List<String> participantIds;

  const CreateAppointment({required this.buildContext, required this.appointmentIn, required this.participantIds});

  @override
  List<Object> get props => [buildContext, appointmentIn, participantIds];
}

// class UpdateContact extends ContactEvent{
//   final BuildContext buildContext;
//   final Contact contactIn;
//   final String contactId;

//   const UpdateContact({required this.buildContext, required this.contactIn, required this.contactId});

//   @override
//   List<Object> get props => [buildContext, contactIn, contactId];
// }