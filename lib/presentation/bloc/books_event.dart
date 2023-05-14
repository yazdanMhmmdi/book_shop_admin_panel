part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class FetchEvent extends BooksEvent {
  String? category;
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
      categoryId = "",
      price = "",
      salesCount = "",
      bookId = "";
  bool isMobile = false;
  BuildContext? context;
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
    this.categoryId,
    this.price,
    this.salesCount,
    required this.isMobile,
    required this.pictureFile,
    this.context,
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
        categoryId!,
        price!,
        salesCount!,
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
      price = "",
      salesCount = "",
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
    this.price,
    this.salesCount,
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
        price!,
        salesCount!,
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

class SearchEvent extends BooksEvent {
  String? categoryId = "";
  String? search = "";
  bool increasePage = false;

  SearchEvent({
    required this.search,
    required this.categoryId,
    this.increasePage = false,
  });

  @override
  List<Object> get props => [
        search!,
        categoryId!,
        increasePage,
      ];
}

class ResetEvent extends BooksEvent {}
