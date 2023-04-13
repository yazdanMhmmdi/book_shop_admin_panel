part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class FetchEvent extends BooksEvent {
  int? category;
  FetchEvent({this.category});

  @override
  List<Object> get props => [category!];
}

class EditEvent extends BooksEvent {
  String? name = "",
      writer = "",
      description = "",
      language = "",
      coverType = "",
      pagesCount = "",
      voteCount = "",
      bookId = "";
  File? pictureFile;
  EditEvent({
    this.bookId,
    this.name,
    this.writer,
    this.voteCount,
    this.pagesCount,
    this.language,
    this.description,
    this.coverType,
    required this.pictureFile,
  });

  @override
  List<Object> get props => [
        coverType!,
        bookId!,
        description!,
        language!,
        name!,
        writer!,
        pagesCount!,
        voteCount!,
        pictureFile!,
      ];
}

class AddEvent extends BooksEvent {
  String? name = "",
      writer = "",
      description = "",
      language = "",
      coverType = "",
      pagesCount = "",
      voteCount = "",
      categoryId = "";
  File? pictureFile;
  AddEvent({
    this.categoryId,
    this.name,
    this.writer,
    this.voteCount,
    this.pagesCount,
    this.language,
    this.description,
    this.coverType,
    required this.pictureFile,
  });

  @override
  List<Object> get props => [
        coverType!,
        categoryId!,
        description!,
        language!,
        name!,
        writer!,
        pagesCount!,
        voteCount!,
        pictureFile!,
      ];
}

class DeleteEvent extends BooksEvent {
  String? bookId = "";
  DeleteEvent({
    required this.bookId,
  });

  @override
  List<Object> get props => [
        bookId!,
      ];
}
