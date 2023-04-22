part of 'form_validation_cubit.dart';

class FormValidationState extends Equatable {
  bool isUsernameValid = false, isPasswordValid = false;
  String errorMessage;

  FormValidationState(
      {required this.isUsernameValid,
      required this.isPasswordValid,
      this.errorMessage = ""});
  @override
  List<Object> get props => [isUsernameValid, isPasswordValid, errorMessage];
}
