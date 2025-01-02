import 'package:bloc/bloc.dart';
import 'package:crm/db/appointment.dart';
import 'package:crm/function/repository/appointment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/app_string_constant.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;
  AppointmentBloc(this.appointmentRepository) : super(AppointmentInitial()) {
    on<CreateAppointment>((event, emit) async {
      try {
        emit(AppointmentLoading());

        if (event.appointmentIn.title.isEmpty) {
          emit(const AppointmentError(AppString.errorFormValidate));
          return;
        }

        final appointmentAdded =
            await appointmentRepository.addAppointment(event.appointmentIn);
        if (appointmentAdded != null) {
          emit(const AppointmentLoaded("Successfully added action"));
        } else {
          emit(const AppointmentError("Failed to add action"));
          return;
        }
        if (event.participantIds != null && event.participantIds.isNotEmpty) {
          emit(AppointmentLoading());

          if (appointmentAdded.id == null) {
            emit(const AppointmentError(
                "appointment ID is missing for assigning participants"));
            return;
          }

          try {
            final assignAppointment = await appointmentRepository
                .assignAppointment(appointmentAdded.id!, event.participantIds);

            if (assignAppointment) {
              emit(AppointmentLoaded(
                  "Successfully assigned users to appointment : ${appointmentAdded.title}"));
            } else {
              emit(AppointmentError(
                  "Failed to assign users to appointment : ${appointmentAdded.title}"));
            }
          } catch (e) {
            emit(AppointmentError(
                "Error assigning participants to appointment with ID: ${appointmentAdded.title}. Error: $e"));
          }
        }
      } catch (e) {
        emit(AppointmentError(e.toString()));
      }
    });
  }
}
