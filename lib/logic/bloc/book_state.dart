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

class BookSelectedReturn extends BookState {
  String name, language, description, writer, voteCount, pageCount, coverType;
  BookModel bookModel;
  BookSelectedReturn(
      {this.description,
      this.language,
      this.name,
      this.writer,
      this.bookModel,
      this.pageCount,
      this.voteCount,
      this.coverType});
  @override
  List<Object> get props => [
        this.description,
        this.language,
        this.name,
        this.writer,
        this.bookModel,
        this.pageCount,
        this.voteCount,
        this.coverType
      ];
}

class BookFailure extends BookState {
  String error_message;
  BookFailure({@required this.error_message});
}
