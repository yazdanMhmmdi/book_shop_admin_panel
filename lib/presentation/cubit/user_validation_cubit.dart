import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/constants/constants.dart';

part 'user_validation_state.dart';

class UserValidationCubit extends Cubit<UserValidationState> {
  String usernameError = "", passwordError = "";
  UserValidationCubit() : super(UserValidationStatus());

  void usernameValidation(String text) {
    if (text.isEmpty) {
      usernameError = "نام کاربری نمی تواند خالی باشد";
    } else if (text.length < 8) {
      usernameError = "نام کاربری نمی تواند کمتر از 8 کارکتر باشد";
    } else if (!kValidCharacters.hasMatch(text)) {
      usernameError =
          "از حروف انگلیسی، اعداد و کارکترهای ._-=@  در نام کاربری خود استفاده کنید";
    } else {
      usernameError = "";
    }
    emit(
        UserValidationStatus(username: usernameError, password: passwordError));
  }

  void passwrodValidation(String text) {
    if (text.isEmpty) {
      passwordError = "رمز عبور نمی تواند خالی باشد";
    } else if (text.length < 8) {
      passwordError = "رمز عبور نمی تواند کمتر از 8 کارکتر باشد";
    } else {
      passwordError = "";
    }
    emit(
        UserValidationStatus(username: usernameError, password: passwordError));
  }
}
