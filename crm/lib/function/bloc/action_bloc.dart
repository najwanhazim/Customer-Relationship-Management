import 'package:bloc/bloc.dart';
import 'package:crm/function/repository/task_action_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../db/task_action.dart';
import '../../utils/app_string_constant.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  final TaskActionRepository taskActionRepository;

  ActionBloc(this.taskActionRepository) : super(ActionInitial()) {
    on<CreateAction>((event, emit) async {
      try {
        emit(ActionLoading());

        // Validate action input
        if (event.actionIn.action.isEmpty) {
          emit(const ActionError(AppString.errorFormValidate));
          return;
        }

        // Add task action
        final actionAdded =
            await taskActionRepository.addTaskAction(event.actionIn);

        if (actionAdded != null) {
          emit(const ActionLoaded("Successfully added action"));
        } else {
          emit(const ActionError("Failed to add action"));
          return;
        }

        // Handle participants if present
        if (event.participants != null && event.participants.isNotEmpty) {
          emit(ActionLoading());

          // Ensure ID is valid before assigning action
          for (TaskAction action in actionAdded) {
            if (action.id == null) {
              emit(const ActionError(
                  "Task ID is missing for assigning participants"));
              return;
            }

            try {
              final assignAction = await taskActionRepository.assignAction(
                action.id!,
                event.participants,
              );

              if (assignAction) {
                emit(ActionLoaded(
                    "Successfully assigned users to action with ID: ${action.action}"));
              } else {
                emit(ActionError(
                    "Failed to assign users to action with ID: ${action.action}"));
              }
            } catch (e) {
              emit(ActionError(
                  "Error assigning participants to action with ID: ${action.action}. Error: $e"));
            }
          }
        }
      } catch (e) {
        emit(ActionError(e.toString()));
      }
    });
  }
}
