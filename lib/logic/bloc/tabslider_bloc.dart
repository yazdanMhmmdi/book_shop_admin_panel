import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/category_bloc.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        yield TabsliderSuccess(
            MultiBlocProvider(providers: [
              BlocProvider.value(value: event.tabSliderBloc),
            ], child: CategoryTab()),
            CategoryTab());
      else if (event.tab == 1)
        yield TabsliderSuccess(UsersTab(), UsersTab());
      else if (event.tab == 2) {
        yield TabsliderSuccess(
            MultiBlocProvider(providers: [
              BlocProvider.value(value: event.tabSliderBloc),
              BlocProvider.value(
                value: event.categoryBloc,
              )
            ], child: BooksTab()),
            BooksTab());
      }
    }
  }
}
