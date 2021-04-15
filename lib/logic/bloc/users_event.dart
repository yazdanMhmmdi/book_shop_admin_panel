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
