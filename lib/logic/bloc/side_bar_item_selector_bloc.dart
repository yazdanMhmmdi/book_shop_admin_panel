import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_user_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/show_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

part 'side_bar_item_selector_event.dart';
part 'side_bar_item_selector_state.dart';

class SideBarItemSelectorBloc
    extends Bloc<SideBarItemSelectorEvent, SideBarItemSelectorState> {
  SideBarItemSelectorBloc() : super(SideBarItemSelectorInitial());

  BookBloc _bookBloc;
  bool isAnyItemSelected = false;
  @override
  Stream<SideBarItemSelectorState> mapEventToState(
    SideBarItemSelectorEvent event,
  ) async* {
    if (event is SelectItemEvent) {
      yield SideBarItemSelectorInitial();
      if (event.orginalTab is UsersTab) {
        yield SideBarItemSelectorSuccess(
            add: false,
            editFunction: () => ShowDialog.showDialog(
                event.context,
                BlocProvider.value(
                    value: event.usersBloc, child: EditUserDialog())));
      } else if (event.orginalTab is BooksTab) {
        _bookBloc = event.bookBloc;

        yield SideBarItemSelectorSuccess(
            add: true,
            editFunction: () {
              _bookBloc.stream.listen((state) {
                if (state is GetSelectedItem) {
                  isAnyItemSelected = true;
                } else {}
              });
              if (isAnyItemSelected)
                ShowDialog.showDialog(
                    event.context,
                    BlocProvider.value(
                      child: EditBookDialog(),
                      value: _bookBloc,
                    ));
              else {
                // showToast("msg", context: context);
              }
            });
      }
    }
  }
}
