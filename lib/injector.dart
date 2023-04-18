import 'package:book_shop_admin_panel/core/network/book_remote_api_service.dart';
import 'package:book_shop_admin_panel/core/network/user_remote_api_service.dart';
import 'package:book_shop_admin_panel/core/usecase/usecase.dart';
import 'package:book_shop_admin_panel/data/datasources/remote/book_remote_api_service_impl.dart';
import 'package:book_shop_admin_panel/data/datasources/remote/user_remote_api_service_impl.dart';
import 'package:book_shop_admin_panel/data/repositories/books_repository_impl.dart';
import 'package:book_shop_admin_panel/data/repositories/users_repository_impl.dart';
import 'package:book_shop_admin_panel/domain/repositories/books_repository.dart';
import 'package:book_shop_admin_panel/domain/repositories/users_repository.dart';
import 'package:book_shop_admin_panel/domain/usecases/add_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/delete_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/delete_users_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/edit_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/edit_users_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/get_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/search_users_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/serach_books_usecase.dart';
import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:book_shop_admin_panel/presentation/bloc/users_bloc.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/entities/book_shop_client.dart';
import 'domain/usecases/get_users_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!  Features
  //  Blocs
  sl.registerFactory(() => BooksBloc(
        booksUsecase: sl(),
        editBookUsecase: sl(),
        addBookUsecase: sl(),
        deleteBooksUsecase: sl(),
        searchBooksUsecase: sl(),
      ));

  sl.registerFactory(() => UsersBloc(
        getUsersUsecase: sl(),
        editUsersUsecase: sl(),
        deleteUsersUsecase: sl(),
        searchusersUsecase: sl(),
      ));
//  usecases
  sl.registerLazySingleton(() => GetBooksUsecase(sl()));
  sl.registerLazySingleton(() => EditBookUsecase(sl()));
  sl.registerLazySingleton(() => AddBookUsecase(sl()));
  sl.registerLazySingleton(() => DeleteBooksUsecase(sl()));
  sl.registerLazySingleton(() => SearchBooksUsecase(sl()));
  sl.registerLazySingleton(() => GetUsersUsecase(sl()));
  sl.registerLazySingleton(() => EditUsersUsecase(sl()));
  sl.registerLazySingleton(() => DeleteUsersUsecase(sl()));
  sl.registerLazySingleton(() => SearchUsersUsecase(sl()));

  //!  Data
  //  repositories
  sl.registerLazySingleton<BooksRepository>(() => BooksRepositoryImpl(sl()));
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(sl()));

  //  remote datasources
  sl.registerLazySingleton<BookRemoteApiService>(
      () => BookRemoteApiServiceImpl(sl()));
  sl.registerLazySingleton<UsersRemoteApiService>(
      () => UserRemoteApiServiceImpl(sl()));
  //!  Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton(() => InputConverter());
  //!  Extentions
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  //! Domain
  //entities
  sl.registerSingleton(BookShopClient(sl()));
}
