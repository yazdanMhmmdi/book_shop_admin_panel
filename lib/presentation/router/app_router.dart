import 'package:book_shop_admin_panel/presentation/cubit/form_validation_cubit.dart';

import '../pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/books_bloc.dart';
import '../bloc/users_bloc.dart';
import '../pages/login_page/login_page.dart';
import '../pages/panel_page.dart';

class AppRouter {
  BooksBloc booksBloc = sl();
  UsersBloc usersBloc = sl();
  AuthBloc authBloc = sl();
  FormValidationCubit formValidationCubit = sl();

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return loginPage();
      case '/categorypage':
        return categoryPage();
      case '/panelpage':
        return panelPage();
      case '/loginpage':
        return loginPage();
      default:
        return loginPage();
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
}
