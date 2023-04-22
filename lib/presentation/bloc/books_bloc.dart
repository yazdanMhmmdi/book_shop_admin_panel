import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/constants.dart';
import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/book_model.dart';
import '../../data/models/books_list_model.dart';
import '../../data/models/function_response_model.dart';
import '../../domain/usecases/add_books_usecase.dart';
import '../../domain/usecases/delete_books_usecase.dart';
import '../../domain/usecases/edit_books_usecase.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/serach_books_usecase.dart';
import '../widgets/global_class.dart';

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
    on<ResetEvent>(_resetBook);
  }

  Future<void> _getBooks(FetchEvent event, Emitter<BooksState> emit) async {
    //show loading only one time
    if (page == 1) {
      emit(BooksLoading());
      print("BooksLoading");
    }
    //change category and set values to default
    if (GlobalClass.currentCategoryId != event.category) {
      page = 1;
      totalPage = 1;

      _booksList.clear();
      noMoreData = true;
    }
    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      titlesPostRequestParams!.categoryId = int.parse(event.category!);
      titlesPostRequestParams!.page = page;
      dynamic failureOrPosts = await booksUsecase(titlesPostRequestParams!);
      page++;

      failureOrPosts.fold(
        (failure) {
          print("BookFailure");
        emit(BooksFailure(message: failure.toString()));
        },
        (BooksListModel booksListModel) {
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
    print("BooksSuccess");

//empty list should emit EmptyList state not success
    if (_booksList.isEmpty) {
      emit(BookNothingFound());
    } else {
      emit(BooksSuccess(
        _booksList,
        noMoreData,
      ));
    }
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
    editBookRequestParams!.categoryId = event.categoryId;
    editBookRequestParams!.price = event.price!;
    editBookRequestParams!.salesCount = event.salesCount!;
    dynamic failureOrPosts = await editBookUsecase(editBookRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(BooksFailure(message: failure.toString()));
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
          add(FetchEvent(category: GlobalClass.currentCategoryId));
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
    addBooksRequestParams!.price = event.price!;
    addBooksRequestParams!.salesCount = event.salesCount!;

    dynamic failureOrPosts = await addBookUsecase(addBooksRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(BooksFailure(message: failure.toString()));
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _booksList.clear();
          emit(BooksAdded());
          add(FetchEvent(category: GlobalClass.currentCategoryId));
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
        emit(BooksFailure(message: failure.toString()));
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _booksList.clear();
          emit(BooksDeleted());
          add(FetchEvent(category: GlobalClass.currentCategoryId.toString()));
        }
      },
    );
  }

  Future<void> _searchBooks(SearchEvent event, Emitter<BooksState> emit) async {
    //change category and set values to default
    if (GlobalClass.currentCategoryId != event.categoryId) {
      page = 1;
      totalPage = 1;
      // currentCategory = event.categoryId!;
      _booksList.clear();
      noMoreData = true;
      emit(BooksLoading());
    }

    if (event.increasePage) page++;

    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      searchBooksRequestParams!.categoryId = event.categoryId;
      searchBooksRequestParams!.page = page.toString();
      searchBooksRequestParams!.search = event.search;
      dynamic failureOrPosts =
          await searchBooksUsecase(searchBooksRequestParams!);

      failureOrPosts.fold(
        (failure) {
          print("BookFailure");
        emit(BooksFailure(message: failure.toString()));
        },
        (BooksListModel booksListModel) {
          print('BookSuccess');

          if (booksListModel.books!.isEmpty) {
            noMoreData = false;
            emit(BookNothingFound());
          } else {
            totalPage = booksListModel.data!.totalPages!;
            // _booksList.addAll(booksListModel.books!);
            _booksList.addAll(booksListModel.books!);
            if (page > totalPage) noMoreData = false;

            emit(BooksSuccess(
              _booksList,
              noMoreData,
            ));
          }
        },
      );
    }
  }

  Future<void> _resetBook(ResetEvent event, Emitter<BooksState> emit) async {
    page = 1;
    _booksList = [];
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
