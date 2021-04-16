part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {}

class DisposeUsersEvent extends UsersEvent {}

class SelectUsersEvent extends UsersEvent {
  String user_id;
  SelectUsersEvent({this.user_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.user_id];
}

class ReturnSelectedEvent extends UsersEvent {
  ReturnSelectedEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditUsersEvent extends UsersEvent {
  String user_id, username, password;
  EditUsersEvent({this.user_id, this.username, this.password});
  @override
  // TODO: implement props
  List<Object> get props => [this.user_id, this.username, this.password];
}

class SearchUsersEvent extends UsersEvent {
  String page, search;
  bool isLazyLoad = false;

  SearchUsersEvent({this.search, this.page, this.isLazyLoad});
  @override
  // TODO: implement props
  List<Object> get props => [this.page, this.search, this.isLazyLoad];
}

class DeleteUserEvent extends UsersEvent {}
