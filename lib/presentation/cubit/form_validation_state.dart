part of 'form_validation_cubit.dart';

class FormValidationState extends Equatable {
  bool? isUsernameValid = false,
      isPasswordValid = false,
      isBookNameValid = false,
      isBookWriterValid = false;
  String errorMessage;

  FormValidationState(
      {required this.isUsernameValid,
      required this.isPasswordValid,
      required this.isBookNameValid,
      required this.isBookWriterValid,
      this.errorMessage = ""});
  @override
  List<Object> get props => [
        isUsernameValid!,
        isPasswordValid!,
        isBookWriterValid!,
        isBookNameValid!,
        errorMessage
      ];
}
