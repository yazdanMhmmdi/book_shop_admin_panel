import 'package:book_shop_admin_panel/presentation/cubit/detail_cubit.dart';
import 'package:book_shop_admin_panel/presentation/cubit/form_validation_cubit.dart';
import 'package:book_shop_admin_panel/presentation/cubit/internet_cubit.dart';
import 'package:book_shop_admin_panel/presentation/pages/edit_page/edit_page_mobile.dart';

import '../cubit/book_edit_validation_cubit.dart';
import '../pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/books_bloc.dart';
import '../bloc/users_bloc.dart';
import '../pages/login_page/login_page.dart';
import '../pages/panel_page/panel_page.dart';

class AppRouter {
  BooksBloc booksBloc = sl();
  UsersBloc usersBloc = sl();
  AuthBloc authBloc = sl();
  FormValidationCubit formValidationCubit = sl();
  InternetCubit internetCubit = sl();

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return panelPage();
      case '/categorypage':
        return categoryPage();
      case '/panelpage':
        return panelPage();
      case '/loginpage':
        return loginPage();
      case '/editPage':
        return editPage(settings);
      default:
        return panelPage();
    }
  }

  MaterialPageRoute loginPage() {
    return MaterialPageRoute(
        builder: ((context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: authBloc,
                ),
                BlocProvider.value(
                  value: formValidationCubit,
                ),
              ],
              child: const LoginPage(),
            )));
  }

  MaterialPageRoute categoryPage() {
    return MaterialPageRoute(builder: ((context) => const CategoryPage()));
  }

  MaterialPageRoute panelPage() {
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
              child: const PanelPage(),
            )));
  }

  MaterialPageRoute editPage(RouteSettings settings) {
    final Map<String, String?> args =
        settings.arguments as Map<String, String?>;

    return MaterialPageRoute(
        builder: ((context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DetailCubit(),
                ),
                BlocProvider.value(value: formValidationCubit),
                BlocProvider(
                  create: (context) => BookEditValidationCubit(),
                ),
                BlocProvider.value(
                  value: internetCubit,
                ),
                BlocProvider(
                  create: (context) => BooksBloc(
                    addBookUsecase: sl(),
                    booksUsecase: sl(),
                    deleteBooksUsecase: sl(),
                    editBookUsecase: sl(),
                    searchBooksUsecase: sl(),
                  ),
                ),
              ],
              child: EditPageMobile(
                args: args,
              ),
            )));
  }
}
