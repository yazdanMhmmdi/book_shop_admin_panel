part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBookEvent extends BookEvent {
  GetBookEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
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

class EditBookEvent extends BookEvent {
  File file;
  String name;
  String language;
  String description;
  String coverType;
  String pageCount;
  String vote;
  String writer;
  String book_id;
  EditBookEvent(
      {this.file,
      this.name,
      this.language,
      this.description,
      this.coverType,
      this.pageCount,
      this.book_id,
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
        book_id,
        vote,
        writer
      ];
}

class SelectBookEvent extends BookEvent {
  String book_id;
  SelectBookEvent({@required this.book_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}

class ReturnSelectedBookEvent extends BookEvent {}

class DisposeBookEvent extends BookEvent {}

class SearchBookEvent extends BookEvent {
  String search, category_id;
  bool isLazyLoad = false;

  SearchBookEvent({this.category_id, this.search, this.isLazyLoad});

  @override
  // TODO: implement props
  List<Object> get props => [this.search, this.category_id];
}

class AddCategoryEvent extends BookEvent {
  String currentTabCategory;

  AddCategoryEvent({@required this.currentTabCategory});
  @override
  // TODO: implement props
  List<Object> get props => [this.currentTabCategory];
}

