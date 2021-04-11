part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBookEvent extends BookEvent {
  String category_id;
  GetBookEvent({@required this.category_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.category_id];
}

class DeleteBookEvent extends BookEvent {
  String book_id;
  DeleteBookEvent({@required this.book_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}

class AddBookEvent extends BookEvent {
  File file;
  String name;
  String language;
  String description;
  String coverType;
  String pageCount;
  String category_id;
  String vote;
  String writer;
  AddBookEvent(
      {this.file,
      this.name,
      this.language,
      this.description,
      this.coverType,
      this.pageCount,
      this.category_id,
      this.vote,
      this.writer});
  @override
  // TODO: implement props
  List<Object> get props => [
        file,
        name,
        language,
        description,
        coverType,
        pageCount,
        category_id,
        vote,
        writer
      ];
}

class DisposeBookEvent extends BookEvent {}
