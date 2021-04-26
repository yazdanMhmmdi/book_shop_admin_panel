import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/book_model.dart';
import 'package:book_shop_admin_panel/data/model/bookfunc_model.dart';
import 'package:book_shop_admin_panel/data/repository/book_repository.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'book_state.dart';
part 'book_event.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial());
  BookRepository _repository = new BookRepository();
  int counterPage = 0, totalPage;
  BookModel _model;
  String selectedBookId;
  bool isSearch = false;
  String cacheSerach;
  String cachePage;
  String cacheCategory_id;
  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    try {
      if (event is GetBookEvent) {
        // _model = null;
        try {
          counterPage++;
          if (counterPage == 1) {
            yield BookLoading();

            //first time caching
            _model = await _repository.getBooks(
                counterPage.toString(), event.category_id);
            totalPage = _model.data.totalPages;
            print("CATEG PAGE 1");
            yield BookSuccess(bookModel: _model, isSearch: false);
          } else if (counterPage <= totalPage) {
            yield BookLazyLoading(bookModel: _model);
            // page 2 to bigger pages cache
            BookModel _res = await _repository.getBooks(
                counterPage.toString(), event.category_id);
            _res.books.forEach((e) {
              _model.books.add(e);
            });
            print("CATEG PAGE X");

            yield BookSuccess(bookModel: _model, isSearch: false);
          } else {
            print("CATEG PAGE END");
          }
        } catch (err) {
          yield BookFailure(error_message: "");
        }
      } else if (event is DisposeBookEvent) {
        _model = new BookModel();
        totalPage = 0;
        counterPage = 0;
      } else if (event is DeleteBookEvent) {
        yield BookLoading();
        try {
          BookfuncModel _funcModel =
              await _repository.deleteBook(event.book_id);
          if (_funcModel.status == "1") {
            _model.books.removeWhere((book) => book.id == event.book_id);
            yield BookSuccess(bookModel: _model , isSearch: false);
          } else {
            yield BookFailure(error_message: "error delete book");
          }
        } catch (err) {
          yield BookFailure(error_message: "");
        }
      } else if (event is AddBookEvent) {
        yield BookLoading();

        try {
          BookfuncModel _fundModel = await _repository.addBook(
              file: event.file,
              name: event.name,
              language: event.language,
              description: event.description,
              coverType: event.coverType,
              pageCount: event.pageCount,
              category_id: event.category_id,
              vote: event.vote,
              writer: event.writer);
          if (_fundModel.status == "1") {
            //TODO: needs id,picture_thumb, picture from server api;
            print(_model.books[(_model.books.length - 1)].name);
            yield BookSuccess(bookModel: _model, isSearch: false);
          } else {
            yield BookFailure(error_message: "error add book");
          }
        } catch (err) {
          yield BookFailure(error_message: "null");
        }
      } else if (event is EditBookEvent) {
        yield BookLoading();

        try {
          BookfuncModel _fundModel = await _repository.editBook(
              file: event.file,
              name: event.name,
              language: event.language,
              description: event.description,
              coverType: event.coverType,
              pageCount: event.pageCount,
              book_id: event.book_id,
              vote: event.vote,
              writer: event.writer);
          if (_fundModel.status == "1") {
            //TODO: needs id,picture_thumb, picture from server api;
            print(_model.books[(_model.books.length - 1)].name);
            yield BookSuccess(bookModel: _model, isSearch: false);
          } else {
            yield BookFailure(error_message: "error add book");
          }
        } catch (err) {
          yield BookFailure(error_message: "null");
        }
      } else if (event is SelectBookEvent) {
        selectedBookId = event.book_id;

        print('Selected book in bookBloc is : ${selectedBookId}');
      } else if (event is ReturnSelectedBookEvent) {
        for (int i = 0; i < _model.books.length; i++) {
          if (_model.books[i].id == selectedBookId) {
            print("Data: " + _model.books[i].name);
            yield BookSelectedReturn(
                name: _model.books[i].name,
                language: _model.books[i].language,
                description: _model.books[i].description,
                writer: _model.books[i].writer,
                bookModel: _model,
                pageCount: _model.books[i].pagesCount,
                voteCount: _model.books[i].voteCount,
                coverType: _model.books[i].coverType);
            break;
          }
        }
      } else if (event is SearchBookEvent) {
        if (!event.isLazyLoad) {
          if (event.search == "") {
            this.add(DisposeBookEvent());
            this.add(GetBookEvent(category_id: event.category_id));
          }
        }
        try {
          counterPage++;
          if (counterPage == 1) {
            yield BookLoading();
            _model = await _repository.searcBook(
                search: event.search,
                category_id: event.category_id,
                page: counterPage.toString());
            totalPage = _model.data.totalPages;
            //caching
            cacheSerach = event.search;
            cachePage = counterPage.toString();
            cacheCategory_id = event.category_id;

            yield BookSuccess(bookModel: _model, isSearch: true);
          } else if (counterPage <= totalPage) {
            yield BookSearchLazyLoading(bookModel: _model);
            BookModel _res = await _repository.searcBook(
                search: cacheSerach,
                category_id: cacheCategory_id,
                page: counterPage.toString());
            _res.books.forEach((e) {
              _model.books.add(e);
            });
            yield BookSuccess(bookModel: _model, isSearch: true);
          }
        } catch (err) {
          yield BookFailure(
              error_message: "SearchBookEvent -> BoolFailure: ${err}");
        }
      }
    } catch (e) {
      print("ERROR ${e.toString()}");
    }
  }
}
