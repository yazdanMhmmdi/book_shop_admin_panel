part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersSuccess extends UsersState {
  UsersModel usersModel;
  String selectedUserId;
  bool isSearch;

  UsersSuccess(
      {@required this.usersModel, this.selectedUserId, this.isSearch}) {
    print('UsersSuccess');
  }

  @override
  List<Object> get props => [this.usersModel];
}

class UsersLoading extends UsersState {}

class UsersLazyLoading extends UsersState {
  UsersModel usersModel;
  UsersLazyLoading({@required this.usersModel}) {
    print('Userlazyloading');
  }
  @override
  List<Object> get props => [this.usersModel];
}

class ReturnSelectedUser extends UsersState {
  String username, password, user_id;
  UsersModel usersModel;
  ReturnSelectedUser(
      {this.password, this.username, this.user_id, this.usersModel}) {
    print('ReturnSelectedUser');
  }
  @override
  List<Object> get props => [this.username, this.password];
}
class UsersSearchLazyLoading extends UsersState {
  UsersModel usersModel;

  UsersSearchLazyLoading({@required this.usersModel});

  @override
  List<Object> get props => [this.usersModel];
}
class UsersFailure extends UsersState {}
