part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  CategoryModel categoryModel;
  CategorySuccess({@required this.categoryModel});

  @override
  List<Object> get props => [this.categoryModel];
}

class CategoryLazyLoading extends CategoryState {
  CategoryModel categoryModel;

  CategoryLazyLoading({@required this.categoryModel});

  @override
  List<Object> get props => [this.categoryModel];
}

class CategoryFailure extends CategoryState {}
