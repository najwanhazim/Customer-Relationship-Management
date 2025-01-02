import 'package:bloc/bloc.dart';
import 'package:crm/db/meeting.dart';
import 'package:crm/function/repository/meeting_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/app_string_constant.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository meetingRepository;

  MeetingBloc(this.meetingRepository) : super(MeetingInitial()) {
    on<CreateMeeting>((event, emit) async {
      try {
        emit(MeetingLoading());

        if (event.meetingIn.title.isEmpty) {
          emit(const MeetingError(AppString.errorFormValidate));
          return;
        }

        final meetingAdded =
            await meetingRepository.addMeetingNote(event.meetingIn);

        if (meetingAdded != null) {
          emit(const MeetingLoaded("Successfully added meeting note"));
        } else {
          emit(const MeetingError("Failed to add meeting notes"));
          return;
        }

        if (meetingAdded.id != null) {
          emit(MeetingLoading());

          print("contact: ${event.contactIds}");
          print("participant: ${event.participantIds}");

          try {
            final assignMeeting = await meetingRepository.assignMeeting(
                meetingAdded.id!,
                event.contactIds,
                event.participantIds,
                event.leadId);

            if (assignMeeting) {
              emit(const MeetingLoaded("Successfully assign meeting note"));
            } else {
              emit(const MeetingError("Failed to assign meeting notes"));
              return;
            }
          } catch (e) {
            emit(MeetingError(
                "Error assigning to meeting with ID: ${meetingAdded.title}. Error: $e"));
          }
        } else {
          emit(const MeetingError("Missing meeting notes id"));
          return;
        }
      } catch (e) {
        emit(MeetingError(e.toString()));
      }
    });
  }
}
