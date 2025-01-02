import 'package:bloc/bloc.dart';
import 'package:crm/db/leads.dart';
import 'package:crm/function/repository/leads_reposiotry.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lead_event.dart';
part 'lead_state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  LeadsRepository leadsRepository = LeadsRepository();
  LeadBloc(this.leadsRepository) : super(LeadInitial()) {

    on<CreateLead>((event, emit) async{
      try{
        emit(LeadLoading());

        if(event.leadIn.title.isEmpty){
          emit(const LeadError(AppString.errorFormValidate));
          return;
        }

        final response = await leadsRepository.createLead(event.leadIn, event.contactIds);

        if(response){
          emit(LeadLoaded("Successfully added contact", response));
        } else {
          emit(LeadLoaded("Failed to add contact", response));
        }
      } on Exception catch(e) {
        emit(LeadError(e.toString()));
      }
    });
  }
}