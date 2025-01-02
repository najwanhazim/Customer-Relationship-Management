import 'package:bloc/bloc.dart';
import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../db/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;
  ContactBloc(this.contactRepository) : super(ContactInitial()) {
    
    on<CreateContact>((event, emit) async{
      try{
        emit(ContactLoading());

        if(event.contactIn.fullname.isEmpty || event.contactIn.phone_no.isEmpty || event.contactIn.email.isEmpty) {
          emit(const ContactError(AppString.errorFormValidate));
          return;
        }

        final addContactState = await contactRepository.createContact(event.contactIn);

        if(addContactState){
          emit(ContactLoaded("Successfully added contact", addContactState));
        } else {
          emit(ContactLoaded("Failed to add contact", addContactState));
        }
      } on Exception catch(e) {
        emit(ContactError(e.toString()));
      }
    });

    on<UpdateContact>((event, emit) async{
      try{
        emit(ContactLoading());

        final updateContact = await contactRepository.updateContact(event.contactIn, event.contactId);

        if(updateContact){
          emit(ContactLoaded("Successfully update contact", updateContact));
        } else {
          emit(ContactLoaded("Failed to update contact", updateContact));
        }
      } on Exception catch(e) {
        emit(ContactError(e.toString()));
      }
    });
  }
}