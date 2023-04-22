import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/params/request_params.dart';
import '../../data/models/function_response_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/users_list_model.dart';
import '../../domain/usecases/delete_users_usecase.dart';
import '../../domain/usecases/edit_users_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUsecase getUsersUsecase;
  final EditUsersUsecase editUsersUsecase;
  final DeleteUsersUsecase deleteUsersUsecase;
  final SearchUsersUsecase searchusersUsecase;

  GetUsersRequestParams? getUsersRequestParams = GetUsersRequestParams();
  EditUsersRequestParams? editUsersRequestParams = EditUsersRequestParams();
  DeleteUsersRequestParams? deleteUsersRequestParams =
      DeleteUsersRequestParams();
  SearchUsersRequestParams? searchUsersRequestParams =
      SearchUsersRequestParams();

  List<UserModel> _usersList = <UserModel>[];
  bool noMoreData = true;
  int page = 1;
  double totalPage = 1;
  UsersBloc({
    required this.getUsersUsecase,
    required this.editUsersUsecase,
    required this.deleteUsersUsecase,
    required this.searchusersUsecase,
  }) : super(UsersInitial()) {
    on<GetUsersEvent>(_getUsers);
    on<EditUsersEvent>(_editUsers);
    on<DeleteUsersEvent>(_deleteUsers);
    on<SearchUsersEvent>(_searchUsers);
    on<ResetUsersEvent>(_resetUsers);
  }

  Future<void> _getUsers(GetUsersEvent event, Emitter<UsersState> emit) async {
    //show loading only one time
    if (page == 1) {
      emit(UsersLoading());
      print("UsersLoading");
    }
    //change category and set values to default
    // if (GlobalClass.currentCategoryId != event.category) {
    //   page = 1;
    //   totalPage = 1;

    //   _usersList.clear();
    //   noMoreData = true;
    // }
    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      getUsersRequestParams!.page = page.toString();
      dynamic failureOrPosts = await getUsersUsecase(getUsersRequestParams!);
      page++;

      failureOrPosts.fold(
        (failure) {
          print("UserFailure");
        emit(UsersFailure(message: failure.toString()));
        },
        (UsersListModel usersListModel) {
          if (usersListModel.users!.isEmpty) {
            noMoreData = false;
            emit(UsersLoading());
            emit(UserNothingFound());
          }
          emit(UsersLoading());

          totalPage = usersListModel.data!.totalPages!;
          _usersList.addAll(usersListModel.users!);
        },
      );
    }
    if (page > totalPage) noMoreData = false;

    //empty list should emit EmptyList state not success
    if (_usersList.isEmpty) {
      emit(UserNothingFound());
    } else {
      print('Usersuccess');
      emit(UsersSuccess(
        _usersList,
        noMoreData,
      ));
    }
  }

  Future<void> _editUsers(
      EditUsersEvent event, Emitter<UsersState> emit) async {
    editUsersRequestParams!.userId = event.userId!;
    editUsersRequestParams!.username = event.username!;
    editUsersRequestParams!.password = event.password!;
    editUsersRequestParams!.ruleType = event.ruleType!;

    dynamic failureOrPosts = await editUsersUsecase(editUsersRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("UersFailure");
        emit(UsersFailure(message: failure.toString()));
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _usersList.clear();
          emit(UsersEdited());
          add(GetUsersEvent());
        }
      },
    );
  }

  Future<void> _deleteUsers(
      DeleteUsersEvent event, Emitter<UsersState> emit) async {
    deleteUsersRequestParams!.userId = event.userId!;

    dynamic failureOrPosts =
        await deleteUsersUsecase(deleteUsersRequestParams!);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(UsersFailure(message: failure.toString()));
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          page = 1;
          _usersList.clear();
          emit(UsersDeleted());
          add(GetUsersEvent());
        }
      },
    );
  }

  Future<void> _searchUsers(
      SearchUsersEvent event, Emitter<UsersState> emit) async {
    if (event.increasePage) page++;

    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      searchUsersRequestParams!.page = page.toString();
      searchUsersRequestParams!.search = event.search;
      dynamic failureOrPosts =
          await searchusersUsecase(searchUsersRequestParams!);

      failureOrPosts.fold(
        (failure) {
          print("BookFailure");
        emit(UsersFailure(message: failure.toString()));
        },
        (UsersListModel usersListModel) {
          print('UsersSuccess');

          if (usersListModel.users!.isEmpty) {
            noMoreData = false;
            emit(UserNothingFound());
          } else {
            totalPage = usersListModel.data!.totalPages!;
            // _booksList.addAll(booksListModel.books!);
            _usersList.addAll(usersListModel.users!);
            if (page > totalPage) noMoreData = false;

            emit(UsersSuccess(
              _usersList,
              noMoreData,
            ));
          }
        },
      );
    }
  }

  Future<void> _resetUsers(
      ResetUsersEvent event, Emitter<UsersState> emit) async {
    page = 1;
    _usersList = [];
  }
}
