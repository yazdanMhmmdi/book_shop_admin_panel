import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/book_model.dart';
import 'package:book_shop_admin_panel/data/model/users_model.dart';
import 'package:book_shop_admin_panel/data/repository/users_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial());
  UsersRepository _repository = new UsersRepository();

  int counterPage = 0, totalPage;
  UsersModel _model;
  String selectedUserId;

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is GetUsersEvent) {
      try {
        counterPage++;
        if (counterPage == 1) {
          yield UsersLoading();

          //first time caching
          _model = await _repository.getUsers(counterPage.toString());
          totalPage = _model.data.totalPages;

          yield UsersSuccess(usersModel: _model);
        } else if (counterPage <= totalPage) {
          yield UsersLazyLoading(usersModel: _model);
          // page 2 to bigger pages cache
          UsersModel _res = await _repository.getUsers(counterPage.toString());
          _res.users.forEach((e) {
            _model.users.add(e);
          });

          yield UsersSuccess(usersModel: _model);
        } else {}
      } catch (err) {
        yield UsersFailure();
      }
    } else if (event is SelectUsersEvent) {
      selectedUserId = event.user_id;
    } else if (event is DisposeUsersEvent) {
      _model = new UsersModel();
      totalPage = 0;
      counterPage = 0;
    } else if (event is ReturnSelectedEvent) {
      for (int i = 0; i < _model.users.length; i++) {
        if (_model.users[i].id == selectedUserId) {
          yield ReturnSelectedUser(
              user_id: _model.users[i].id,
              username: _model.users[i].username,
              password: _model.users[i].password,
              usersModel: _model);
        }
      }
    } else if (event is EditUsersEvent) {
      UsersModel _ml = await _repository.editUsers(
          event.user_id, event.username, event.password);
      if (_ml.error == "0") {
        yield UsersSuccess(usersModel: _model);
      }
    } else if (event is DeleteUserEvent) {
      yield UsersLoading();
      UsersModel _ml = await _repository.deleteUsers(selectedUserId);
      if (_ml.error == "0") {
        // _model.users.removeWhere((user) => user.id == selectedUserId);
        for (int i = 0; i < _model.users.length; i++) {
          if (_model.users[i].id == selectedUserId) {
            _model.users.removeAt(i);
            yield UsersSuccess(usersModel: _model);
          }
        }
      } else {
        yield UsersFailure();
      }
    }
  }
}
