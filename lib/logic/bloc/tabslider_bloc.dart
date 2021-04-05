import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:equatable/equatable.dart';

part 'tabslider_event.dart';
part 'tabslider_state.dart';

class TabsliderBloc extends Bloc<TabsliderEvent, TabsliderState> {
  TabsliderBloc() : super(TabsliderInitial());

  @override
  Stream<TabsliderState> mapEventToState(
    TabsliderEvent event,
  ) async* {
    if (event is MoveForwardEvent) {
      if (event.tab == 0)
        yield TabsliderSuccess(CategoryTab());
      else
        yield TabsliderSuccess(UsersTab());
    }
  }
}
