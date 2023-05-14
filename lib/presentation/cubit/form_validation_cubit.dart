import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  static bool isUsernameValid = true,
      isPasswordValid = true,
      isBookNameVaild = true,
      isBookWriterValid = true;
  FormValidationCubit()
      : super(FormValidationState(
          isUsernameValid: isUsernameValid,
          isPasswordValid: isPasswordValid,
          isBookNameValid: isBookNameVaild,
          isBookWriterValid: isBookWriterValid,
        ));

  void usernameValidate(String username) {
    if (username.length < 17 && username.length >= 5) {
      isUsernameValid = true;
    } else {
      isUsernameValid = false;
    }

    emit(FormValidationState(
        isBookNameValid: isBookNameVaild,
        isBookWriterValid: isBookWriterValid,
        isUsernameValid: isUsernameValid,
        isPasswordValid: isPasswordValid));
  }

  void passwordValidate(String password) {
    if (password.length >= 8 && password.length < 17) {
      isPasswordValid = true;
    } else {
      isPasswordValid = false;
    }

    emit(FormValidationState(
        isBookNameValid: isBookNameVaild,
        isBookWriterValid: isBookWriterValid,
        isUsernameValid: isUsernameValid,
        isPasswordValid: isPasswordValid));
  }

  void usernameIsAlreadyExists(String errorMessage) {
    emit(FormValidationState(
        isUsernameValid: false,
        isPasswordValid: true,
        isBookNameValid: isBookNameVaild,
        isBookWriterValid: isBookWriterValid,
        errorMessage: errorMessage));
  }

}
