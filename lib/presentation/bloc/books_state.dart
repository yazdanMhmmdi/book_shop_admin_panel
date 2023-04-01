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
class BooksEdited extends BooksState {}

class BookNothingFound extends BooksState {}

class BooksSuccess extends BooksState {
  List<BookModel> booksModel;
  bool noMoreData = false;

  BooksSuccess(this.booksModel, this.noMoreData);
}

class BooksFailure extends BooksState {}
