import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/core/constants/assets.dart';
import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:book_shop_admin_panel/domain/usecases/delete_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/edit_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/get_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/serach_books_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../core/constants/constants.dart';
import '../../core/errors/failures.dart';
import '../../data/models/books_list_model.dart';
import '../../domain/usecases/add_books_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUsecase booksUsecase;
  final SearchBooksUsecase searchBooksUsecase;
  final EditBookUsecase editBookUsecase;
  final AddBookUsecase addBookUsecase;
  final DeleteBooksUsecase deleteBooksUsecase;

  BooksRequestParams? titlesPostRequestParams = BooksRequestParams();
  EditBookRequestParams? editBookRequestParams = EditBookRequestParams(
      pictureFile: File(
    Assets.emptyImage,
  ));
  AddBooksRequestParams? addBooksRequestParams = AddBooksRequestParams(
      pictureFile: File(
    Assets.emptyImage,
  ));
  DeleteBooksRequestParams? deleteBooksRequestParams =
      DeleteBooksRequestParams();
  SearchBooksRequestParams? searchBooksRequestParams =
      SearchBooksRequestParams();
  bool noMoreData = true;
  int page = 1;
  double totalPage = 1;
  int currentCategory = 1;
  List<BookModel> _booksList = <BookModel>[];

  BooksBloc({
    required this.booksUsecase,
    required this.editBookUsecase,
    required this.addBookUsecase,
    required this.deleteBooksUsecase,
    required this.searchBooksUsecase,
  }) : super(BooksInitial()) {
    on<FetchEvent>(_getBooks);
    on<SearchEvent>(_searchBooks);
    on<EditEvent>(_editBook);
    on<AddEvent>(_addBook);
    on<DeleteEvent>(_deleteBook);
  }

  Future<void> _getBooks(FetchEvent event, Emitter<BooksState> emit) async {
    //change category and set values to default
    if (currentCategory != event.category) {
      page = 1;
      totalPage = 1;
      currentCategory = event.category!;
      _booksList.clear();
      noMoreData = true;
      emit(BooksLoading());
    }
    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      titlesPostRequestParams!.categoryId = event.category;
      titlesPostRequestParams!.page = page;
      dynamic failureOrPosts = await booksUsecase(titlesPostRequestParams!);
      page++;

      failureOrPosts.fold(
        (failure) {
          print("BookFailure");
          emit(BooksFailure());
        },
        (BooksListModel booksListModel) {
          print('BookSuccess');

          if (booksListModel.books!.isEmpty) {
            noMoreData = false;
            emit(BooksLoading());
            emit(BookNothingFound());
          }
          emit(BooksLoading());

          totalPage = booksListModel.data!.totalPages!;
          _booksList.addAll(booksListModel.books!);
        },
      );
    }
    if (page > totalPage) noMoreData = false;

    emit(BooksSuccess(
      _booksList,
      noMoreData,
    ));
  }

  Future<void> _editBook(EditEvent event, Emitter<BooksState> emit) async {
    editBookRequestParams!.bookId = event.bookId!;
    editBookRequestParams!.coverType = event.coverType!;
    editBookRequestParams!.description = event.description!;
    editBookRequestParams!.language = event.language!;
    editBookRequestParams!.name = event.name!;
    editBookRequestParams!.pagesCount = event.pagesCount!;
    editBookRequestParams!.pictureFile = event.pictureFile;
    editBookRequestParams!.voteCount = event.voteCount!;
    editBookRequestParams!.writer = event.writer!;
    dynamic failureOrPosts = await editBookUsecase(editBookRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(BooksFailure());
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _booksList.clear();
          emit(BooksEdited());
          add(FetchEvent(category: 1));
        }
      },
    );
  }

  Future<void> _addBook(AddEvent event, Emitter<BooksState> emit) async {
    addBooksRequestParams!.categoryId = event.categoryId!;
    addBooksRequestParams!.coverType = event.coverType!;
    addBooksRequestParams!.description = event.description!;
    addBooksRequestParams!.language = event.language!;
    addBooksRequestParams!.name = event.name!;
    addBooksRequestParams!.pagesCount = event.pagesCount!;
    addBooksRequestParams!.pictureFile = event.pictureFile;
    addBooksRequestParams!.voteCount = event.voteCount!;
    addBooksRequestParams!.writer = event.writer!;
    dynamic failureOrPosts = await addBookUsecase(addBooksRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(BooksFailure());
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _booksList.clear();
          emit(BooksEdited());
          add(FetchEvent(category: 1));
        }
      },
    );
  }

  Future<void> _deleteBook(DeleteEvent event, Emitter<BooksState> emit) async {
    deleteBooksRequestParams!.bookId = event.bookId!;

    dynamic failureOrPosts =
        await deleteBooksUsecase(deleteBooksRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(BooksFailure());
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _booksList.clear();
          emit(BooksEdited());
          add(FetchEvent(category: 1));
        }
      },
    );
  }

  Future<void> _searchBooks(SearchEvent event, Emitter<BooksState> emit) async {
    //change category and set values to default
    if (currentCategory != event.categoryId) {
      page = 1;
      totalPage = 1;
      currentCategory = int.parse(event.categoryId!);
      _booksList.clear();
      noMoreData = true;
      emit(BooksLoading());
    }
    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      searchBooksRequestParams!.categoryId = event.categoryId;
      searchBooksRequestParams!.page = page.toString();
      searchBooksRequestParams!.search = event.search;
      dynamic failureOrPosts =
          await searchBooksUsecase(searchBooksRequestParams!);
      page++;

      failureOrPosts.fold(
        (failure) {
          print("BookFailure");
          emit(BooksFailure());
        },
        (BooksListModel booksListModel) {
          print('BookSuccess');

          if (booksListModel.books!.isEmpty) {
            noMoreData = false;
            emit(BooksLoading());
            emit(BookNothingFound());
          }
          emit(BooksLoading());

          totalPage = booksListModel.data!.totalPages!;
          _booksList.addAll(booksListModel.books!);
        },
      );
    }
    if (page > totalPage) noMoreData = false;

    emit(BooksSuccess(
      _booksList,
      noMoreData,
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kServerFailureMessage;

      default:
        return 'Unexpected errror';
    }
  }
}
