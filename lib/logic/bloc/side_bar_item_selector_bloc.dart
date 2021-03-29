import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_user_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/show_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'side_bar_item_selector_event.dart';
part 'side_bar_item_selector_state.dart';

class SideBarItemSelectorBloc
    extends Bloc<SideBarItemSelectorEvent, SideBarItemSelectorState> {
  SideBarItemSelectorBloc() : super(SideBarItemSelectorInitial());

  @override
  Stream<SideBarItemSelectorState> mapEventToState(
    SideBarItemSelectorEvent event,
  ) async* {
    if (event is SelectItemEvent) {
      yield SideBarItemSelectorInitial();
      if (event.currentTab is UsersTab) {
        yield SideBarItemSelectorSuccess(
          Column(
            children: [
              SideBarItem(
                child: Image.asset(Assets.edit),
                title: "ویرایش",
                onTap: () =>
                    ShowDialog.showDialog(event.context, EditUserDialog()),
              ),
              SideBarItem(
                child: Image.asset(Assets.delete),
                title: "حذف",
                onTap: () =>
                    ShowDialog.showDialog(event.context, DeleteBookDialog()),
              ),
              SideBarItem(
                child: Image.asset(Assets.search),
                title: "جستجو",
                onTap: () {
                  if (PanelScreen.visiblity == false) {
                    PanelScreen.padding = 57.0;
                    PanelScreen.visiblity = true;
                    PanelScreen.opacity = 1.0;
                  } else {
                    PanelScreen.padding = 0.0;
                    PanelScreen.visiblity = false;
                    PanelScreen.opacity = 0.0;
                  }
                },
              ),
            ],
          ),
        );
      } else if (event.currentTab is BooksTab) {
        yield SideBarItemSelectorSuccess(Column(
          children: [
            SideBarItem(
              child: Image.asset(Assets.add),
              title: "افزودن",
              onTap: () => ShowDialog.showDialog(event.context, PostDialog()),
            ),
            SideBarItem(
              child: Image.asset(Assets.edit),
              title: "ویرایش",
              onTap: () =>
                  ShowDialog.showDialog(event.context, EditUserDialog()),
            ),
            SideBarItem(
              child: Image.asset(Assets.delete),
              title: "حذف",
              onTap: () =>
                  ShowDialog.showDialog(event.context, DeleteBookDialog()),
            ),
            SideBarItem(
              child: Image.asset(Assets.search),
              title: "جستجو",
              onTap: () {
                if (PanelScreen.visiblity == false) {
                  PanelScreen.padding = 57.0;
                  PanelScreen.visiblity = true;
                  PanelScreen.opacity = 1.0;
                } else {
                  PanelScreen.padding = 0.0;
                  PanelScreen.visiblity = false;
                  PanelScreen.opacity = 0.0;
                }
              },
            ),
          ],
        ));
      }
    }
  }
}
