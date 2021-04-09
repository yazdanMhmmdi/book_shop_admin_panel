
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

class DisposeBookEvent extends BookEvent {}
