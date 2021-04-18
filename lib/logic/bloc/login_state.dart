part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {

}

class LoginFailure extends LoginState {
  String errorMessage;
  LoginFailure({this.errorMessage});
  @override
  // TODO: implement props
  List<Object> get props => [this.errorMessage];
}
