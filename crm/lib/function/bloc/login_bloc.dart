import 'package:bloc/bloc.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<VerifyLogin>((event, emit) async{
      try{
        emit(LoginLoading());
        if(event.email.isEmpty || event.password.isEmpty) {
          emit(const LoginError(AppString.errorFormValidate));
          return;
        }

        final loginState = await userRepository.verifyLogin(event.email, event.password, event.buildContext);

        if(loginState) {
          emit(const LoginLoaded("Sucessfully signed in"));
        } else {
          emit(const LoginError('Failed to sign in'));
        }
      } on Exception catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  
  on<CreateSignUp>((event, emit) async{
    try{
      emit(LoginLoading());
        if(event.user.email.isEmpty || event.user.login_id.isEmpty || event.user.full_name.isEmpty) {
          emit(const LoginError(AppString.errorFormValidate));
          return;
        }

        final createState = await userRepository.createUser(event.user);

        if(createState) {
          emit(const LoginLoaded("Sucessfully signed up"));
        } else {
          emit(const LoginError('Failed to sign up'));
        }
    } on Exception catch (e) {
        emit(LoginError(e.toString()));
      }
  });
  }
}