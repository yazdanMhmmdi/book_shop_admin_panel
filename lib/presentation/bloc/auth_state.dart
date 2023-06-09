// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  String message;
  AuthFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthLoading extends AuthState {}
