import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/login_model.dart';
import 'package:book_shop_admin_panel/data/repository/login_repository.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  LoginRepository _repository = new LoginRepository();
  LoginModel _model;
  String user_id;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LogUserInEvent) {
      try {
        yield LoginLoading();
        print("LOginLaoding");
        _model = await _repository.login(event.username, event.password);
        if (_model.error == "0") {
          user_id = _model.userId;
          yield LoginSuccess();
        } else {
          yield LoginFailure(errorMessage: _model.errorMessage);
          print("LoginFailure");
        }
      } catch (err) {
        yield LoginFailure(errorMessage: "${err.toString()}");
        print("LoginFailure");
      }
    }
  }
}
