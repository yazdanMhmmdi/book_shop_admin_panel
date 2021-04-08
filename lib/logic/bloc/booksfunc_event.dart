part of 'booksfunc_bloc.dart';

abstract class BooksfuncEvent extends Equatable {
  const BooksfuncEvent();

  @override
  List<Object> get props => [];
}

class DeleteBookEvent extends BooksfuncEvent {
  String book_id;
  DeleteBookEvent({@required this.book_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}
