part of 'users_bloc.dart';

enum UsersStatus { initial, loading, success, failure }

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

// notify when User edited to scroll up screen

class UserNothingFound extends UsersState {}

class UsersSuccess extends UsersState {
  List<UserModel> usersModel;
  bool noMoreData = false;

  UsersSuccess(this.usersModel, this.noMoreData);
  @override
  List<Object> get props => [
        usersModel,
        noMoreData,
      ];
}

class UsersFailure extends UsersState {}

class UsersAdded extends UsersState {}

class UsersDeleted extends UsersState {}

class UsersEdited extends UsersState {}
