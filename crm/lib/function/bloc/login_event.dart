part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class VerifyLogin extends LoginEvent {
  final String email;
  final String password;
  final BuildContext buildContext;

  const VerifyLogin(this.email, this.password, this.buildContext);

  @override
  List<Object> get props => [email, password, buildContext];
}

class CreateSignUp extends LoginEvent {
  final User user;
  final BuildContext buildContext;

  const CreateSignUp({required this.user, required this.buildContext});

  @override
  List<Object> get props => [user, buildContext];
}