// ignore_for_file: must_be_immutable

part of 'user_validation_cubit.dart';

abstract class UserValidationState extends Equatable {
  const UserValidationState();

  @override
  List<Object> get props => [];
}

class UserValidationStatus extends UserValidationState {
  String username, password;
  UserValidationStatus({this.password = "", this.username = ""});

  @override
  List<Object> get props => [username, password];
}
