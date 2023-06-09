// ignore_for_file: must_be_immutable

part of 'book_edit_validation_cubit.dart';

abstract class BookEditValidationState extends Equatable {
  const BookEditValidationState();

  @override
  List<Object> get props => [];
}

class ValidationStatus extends BookEditValidationState {
  String? bookNameError,
      bookWriterError,
      bookLanguageError,
      bookPagesCountError,
      bookVoteCountError,
      bookSalesCountError,
      bookPriceError,
      bookDescError;
  ValidationStatus(
      {this.bookNameError = "",
      this.bookWriterError = "",
      this.bookLanguageError = "",
      this.bookDescError = "",
      this.bookPagesCountError = "",
      this.bookPriceError = "",
      this.bookSalesCountError = "",
      this.bookVoteCountError = ""});

  @override
  List<Object> get props => [
        bookNameError!,
        bookWriterError!,
        bookLanguageError!,
        bookDescError!,
        bookPagesCountError!,
        bookPriceError!,
        bookSalesCountError!,
        bookVoteCountError!,
      ];
}
