part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersSuccess extends UsersState {
  UsersModel usersModel;
  UsersSuccess({@required this.usersModel});

  @override
  List<Object> get props => [this.usersModel];
}

class UsersLoading extends UsersState {}

class UsersLazyLoading extends UsersState {
  UsersModel usersModel;
  UsersLazyLoading({@required this.usersModel});
  @override
  List<Object> get props => [this.usersModel];
}

class UsersFailure extends UsersState {}
