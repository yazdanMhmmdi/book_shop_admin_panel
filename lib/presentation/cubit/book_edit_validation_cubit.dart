import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_edit_validation_state.dart';

class BookEditValidationCubit extends Cubit<BookEditValidationState> {
  String? bookNameError = "",
      bookWroterError = "",
      bookLanguageError = "",
      bookPagesCountError = "",
      bookVoteCountError = "",
      bookSalesCountError = "",
      bookPriceError = "",
      bookDescError = "";
  BookEditValidationCubit() : super(ValidationStatus());

  void bookNameValidation(String text) {
    if (text.isEmpty) {
      bookNameError = "نام کتاب نمی تواند خالی باشد";
    } else if (text.length > 30) {
      bookNameError = "نام کتاب نباید بیشتر 30 کارکتر باشد";
    } else {
      bookNameError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookPriceError: bookPriceError,
        bookSalesCountError: bookSalesCountError,
        bookDescError: bookDescError));
  }

  void bookWriterValidation(String text) {
    if (text.isEmpty) {
      bookWroterError = "نام نویسنده نمی تواند خالی باشد";
    } else if (text.length > 30) {
      bookWroterError = "نام نویسنده نباید بیشتر 30 کارکتر باشد";
    } else {
      bookWroterError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookPriceError: bookPriceError,
        bookSalesCountError: bookSalesCountError,
        bookDescError: bookDescError));
  }

  void bookLanguageValidation(String text) {
    if (text.isEmpty) {
      bookLanguageError = "زبان کتاب نمی تواند خالی باشد";
    } else if (text.length > 30) {
      bookLanguageError = "زبان کتاب نباید بیشتر 30 کارکتر باشد";
    } else {
      bookLanguageError = "";
    }
    emit(ValidationStatus(
      bookNameError: bookNameError,
      bookWriterError: bookWroterError,
      bookLanguageError: bookLanguageError,
      bookPagesCountError: bookPagesCountError,
      bookVoteCountError: bookVoteCountError,
      bookSalesCountError: bookSalesCountError,
      bookPriceError: bookPriceError,
      bookDescError: bookDescError,
    ));
  }

  void bookPagesCountValidation(String text) {
    if (text.isEmpty) {
      bookPagesCountError = "تعداد صفحات کتاب نمی تواند خالی باشد";
    } else if (int.parse(text) > 10000) {
      bookPagesCountError = "تعداد صفحات کتاب نمی تواند بیشتر 10,000 صفحه باشد";
    } else {
      bookPagesCountError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookPriceError: bookPriceError,
        bookSalesCountError: bookSalesCountError,
        bookDescError: bookDescError));
  }

  void bookVotesValidation(String text) {
    if (text.isEmpty) {
      bookVoteCountError = "امتیازات کتاب نمی تواند خالی باشد";
    } else if (double.parse(text) > 6) {
      bookVoteCountError = "امتیازات کتاب نمیتواند بیشتر از 5 ستاره باشد";
    } else {
      bookVoteCountError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookPriceError: bookPriceError,
        bookSalesCountError: bookSalesCountError,
        bookDescError: bookDescError));
  }

  void bookSalesValidation(String text) {
    if (text.isEmpty) {
      bookSalesCountError = "تعداد فروش کتاب نمی تواند خالی باشد";
    } else if (int.parse(text) > 1000000000) {
      bookSalesCountError =
          "تعداد فروش کتاب نمی تواند بیشتر از 1,000,000,000 عدد باشد";
    } else {
      bookSalesCountError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookPriceError: bookPriceError,
        bookSalesCountError: bookSalesCountError,
        bookDescError: bookDescError));
  }

  void bookPriceValidation(String text) {
    if (text.isEmpty) {
      bookPriceError = "قیمت کتاب نمی تواند خالی باشد";
    } else if (text.length > 16) {
      bookPriceError = "قیمت کتاب  نمی تواند بیشتر از 10,000,000 تومان باشد";
    } else {
      bookPriceError = "";
    }
    emit(ValidationStatus(
      bookNameError: bookNameError,
      bookWriterError: bookWroterError,
      bookLanguageError: bookLanguageError,
      bookPagesCountError: bookPagesCountError,
      bookVoteCountError: bookVoteCountError,
      bookSalesCountError: bookSalesCountError,
      bookPriceError: bookPriceError,
      bookDescError: bookDescError,
    ));
  }

  void bookDescValidation(String text) {
    if (text.isEmpty) {
      bookDescError = "توضیحات کتاب نمی تواند خالی باشد";
    } else if (text.length > 380) {
      bookDescError = "توضیحات کتاب نمی تواند بیشتر از 380 کارکتر باشد";
    } else {
      bookDescError = "";
    }
    emit(ValidationStatus(
        bookNameError: bookNameError,
        bookWriterError: bookWroterError,
        bookLanguageError: bookLanguageError,
        bookPagesCountError: bookPagesCountError,
        bookVoteCountError: bookVoteCountError,
        bookSalesCountError: bookSalesCountError,
        bookPriceError: bookPriceError,
        bookDescError: bookDescError));
  }

  // void bookWriterValidation(String bookWriter) {
  //   if (bookWriter.isEmpty) {
  //     isBookWriterValid = false;

  //     emit(FormValidationState(
  //         isPasswordValid: isPasswordValid,
  //         isUsernameValid: isUsernameValid,
  //         isBookWriterValid: isBookWriterValid,
  //         isBookNameValid: isBookNameVaild,
  //         errorMessage: "نام نویسنده نمی تواند خالی باشد"));
  //   } else if (bookWriter.length > 30) {
  //     isBookWriterValid = false;

  //     emit(FormValidationState(
  //         isPasswordValid: isPasswordValid,
  //         isUsernameValid: isUsernameValid,
  //         isBookWriterValid: isBookWriterValid,
  //         isBookNameValid: isBookNameVaild,
  //         errorMessage: "فیلد نویسنده نباید بیشتر 30 کارکتر باشد"));
  //   } else {
  //     isBookWriterValid = true;
  //     emit(FormValidationState(
  //       isPasswordValid: isPasswordValid,
  //       isUsernameValid: isUsernameValid,
  //       isBookWriterValid: isBookWriterValid,
  //       isBookNameValid: isBookNameVaild,
  //     ));
  //   }
  // }
}
