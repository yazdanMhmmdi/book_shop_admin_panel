part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogUserInEvent extends LoginEvent {
  String username, password;
  LogUserInEvent({this.password, this.username});

  @override
  // TODO: implement props
  List<Object> get props => [this.username, this.password];
}
