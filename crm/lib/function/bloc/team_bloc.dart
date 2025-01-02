import 'package:bloc/bloc.dart';
import 'package:crm/function/repository/team_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/app_string_constant.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamRepository teamRepository = TeamRepository();

  TeamBloc(this.teamRepository) : super(TeamInitial()) {
    on<CreateTeam>((event, emit) async{
      try {
        emit(TeamLoading());

        if (event.participantIds.isEmpty) {
          emit(const TeamError(AppString.errorFormValidate));
          return;
        }

        final assignTeam = await teamRepository.assignTeam(event.participantIds);

        if (assignTeam) {
          emit(const TeamLoaded("Successfully added action"));
        } else {
          emit(const TeamError("Failed to add action"));
          return;
        }
        
      } catch (e) {
        emit(TeamError(e.toString()));
      }
    });

    on<Unassigned>((event, emit) async {
      try {
        emit(TeamLoading());

        if (event.userId.isEmpty) {
          emit(const TeamError(AppString.errorFormValidate));
          return;
        }

        final deleteSuccess = await teamRepository.unassignUser(event.userId);

        if (deleteSuccess) {
          emit(const TeamLoaded("Successfully removed team participants"));
        } else {
          emit(const TeamError("Failed to remove team participants"));
        }
      } catch (e) {
        emit(TeamError(e.toString()));
      }
    });
  }
}
