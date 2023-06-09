// ignore_for_file: must_be_immutable

part of 'books_bloc.dart';

enum BooksStatus { initial, loading, success, failure }

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

// notify when book edited to scroll up screen

class BookNothingFound extends BooksState {}

class BooksSuccess extends BooksState {
  List<BookModel> booksModel;
  bool noMoreData = false;

  BooksSuccess(this.booksModel, this.noMoreData);
  @override
  List<Object> get props => [
        booksModel,
        noMoreData,
      ];
}

class BooksFailure extends BooksState {
  String message;
  BooksFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class BooksAdded extends BooksState {}

class BooksDeleted extends BooksState {}

class BooksEdited extends BooksState {}
