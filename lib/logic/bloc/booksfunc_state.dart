part of 'booksfunc_bloc.dart';

abstract class BooksfuncState extends Equatable {
  const BooksfuncState();

  @override
  List<Object> get props => [];
}

class BooksfuncInitial extends BooksfuncState {}

class BooksfuncLoading extends BooksfuncState {}

class BooksfuncSuccess extends BooksfuncState {}

class BooksfuncFailure extends BooksfuncState {
  String error_message;
  BooksfuncFailure({@required this.error_message});

  @override
  List<Object> get props => [this.error_message];
}
