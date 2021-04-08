import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'booksfunc_event.dart';
part 'booksfunc_state.dart';

class BooksfuncBloc extends Bloc<BooksfuncEvent, BooksfuncState> {
  BooksfuncBloc() : super(BooksfuncInitial());

  @override
  Stream<BooksfuncState> mapEventToState(
    BooksfuncEvent event,
  ) async* {
    if (event is DeleteBookEvent) {
      
    }
  }
}
