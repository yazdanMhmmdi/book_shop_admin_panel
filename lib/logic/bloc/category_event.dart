part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryEvent {
  String category_id;
  GetCategoryEvent({@required this.category_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.category_id];
}

class DisposeCategoryEvent extends CategoryEvent{
  
}
