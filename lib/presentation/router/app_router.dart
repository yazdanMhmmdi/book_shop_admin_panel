import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:book_shop_admin_panel/presentation/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/pages/category_page.dart';
import 'package:book_shop_admin_panel/presentation/pages/login_page.dart';
import 'package:book_shop_admin_panel/presentation/pages/panel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';

class AppRouter {
  BooksBloc booksBloc = BooksBloc(
    booksUsecase: sl(),
    editBookUsecase: sl(),
    addBookUsecase: sl(),
    deleteBooksUsecase: sl(),
    searchBooksUsecase: sl(),
  );
  UsersBloc usersBloc = UsersBloc(
    getUsersUsecase: sl(),
    editUsersUsecase: sl(),
    deleteUsersUsecase: sl(),
    searchusersUsecase: sl(),
  );

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: ((context) => BlocProvider.value(
                  value: booksBloc,
                  child: CategoryPage(),
                )));
      case '/panelpage':
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: booksBloc,
                    ),
                    BlocProvider.value(
                      value: usersBloc,
                    ),
                  ],
                  child: PanelPage(),
                )));
      default:
        return MaterialPageRoute(builder: ((context) => LoginPage()));
    }
  }
}
