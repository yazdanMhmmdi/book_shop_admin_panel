part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookSuccess extends BookState {
  BookModel bookModel;
  BookSuccess({this.bookModel});

  @override
  List<Object> get props => [this.bookModel];
}

class BookLazyLoading extends BookState {
  BookModel bookModel;

  BookLazyLoading({@required this.bookModel});

  @override
  List<Object> get props => [this.bookModel];
}

class BookFailure extends BookState {
  String error_message;
  BookFailure({@required this.error_message});
}
