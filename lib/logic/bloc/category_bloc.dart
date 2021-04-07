import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/category_model.dart';
import 'package:book_shop_admin_panel/data/repository/category_repository.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());
  CategoryRepository _repository = new CategoryRepository();
  int counterPage = 0, totalPage;
  CategoryModel _model;
  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategoryEvent) {
      try {
        counterPage++;
        if (counterPage == 1) {
          yield CategoryLoading();

          //first time caching
          _model = await _repository.getBooksCategory(
              counterPage.toString(), event.category_id);
          totalPage = _model.data.totalPages;
          print("CATEG PAGE 1");
          yield CategorySuccess(categoryModel: _model);
        } else if (counterPage <= totalPage) {
          yield CategoryLazyLoading(categoryModel: _model);
          // page 2 to bigger pages cache
          CategoryModel _res = await _repository.getBooksCategory(
              counterPage.toString(), event.category_id);
          _res.books.forEach((e) {
            _model.books.add(e);
          });
          print("CATEG PAGE X");

          yield CategorySuccess(categoryModel: _model);
        } else {
          print("CATEG PAGE END");
        }
      } catch (err) {
        yield CategoryFailure();
      }
    } else if (event is DisposeCategoryEvent) {
      _model = new CategoryModel();
      totalPage = 0;
      counterPage = 0;
    }
  }
}
