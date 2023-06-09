// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  String? username, password;
  LoginEvent({required this.password, required this.username});

  @override
  List<Object> get props => [username!, password!];
}
