part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {}

class EditUsersEvent extends UsersEvent {
  String? username;
  String? password;
  String? userId;
  String? ruleType;
  EditUsersEvent(
      {required this.username,
      required this.userId,
      required this.password,
      required this.ruleType});

  @override
  List<Object> get props => [password!, userId!, username!, ruleType!];
}

class DeleteUsersEvent extends UsersEvent {
  String? userId;
  DeleteUsersEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId!];
}

class SearchUsersEvent extends UsersEvent {
  String? search = "";
  bool increasePage = false;

  SearchUsersEvent({
    required this.search,
    this.increasePage = false,
  });

  @override
  List<Object> get props => [
        search!,
        increasePage,
      ];
}

class ResetUsersEvent extends UsersEvent {}
