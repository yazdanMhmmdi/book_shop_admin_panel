import 'package:book_shop_admin_panel/core/network/remote_api_service.dart';
import 'package:book_shop_admin_panel/core/usecase/usecase.dart';
import 'package:book_shop_admin_panel/data/datasources/remote/remote_api_service_impl.dart';
import 'package:book_shop_admin_panel/data/repositories/books_repository_impl.dart';
import 'package:book_shop_admin_panel/domain/repositories/books_repository.dart';
import 'package:book_shop_admin_panel/domain/usecases/add_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/edit_books_usecase.dart';
import 'package:book_shop_admin_panel/domain/usecases/get_books_usecase.dart';
import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/entities/book_shop_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!  Features
  //  Blocs
  sl.registerFactory(() => BooksBloc(
        booksUsecase: sl(),
        editBookUsecase: sl(),
        addBookUsecase: sl(),
      ));
//  usecases
  sl.registerLazySingleton(() => GetBooksUsecase(sl()));
  sl.registerLazySingleton(() => EditBookUsecase(sl()));
  sl.registerLazySingleton(() => AddBookUsecase(sl()));

  //!  Data
  //  repositories
  sl.registerLazySingleton<BooksRepository>(() => BooksRepositoryImpl(sl()));
  //  remote datasources
  sl.registerLazySingleton<RemoteApiService>(() => RemoteApiServiceImpl(sl()));
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
