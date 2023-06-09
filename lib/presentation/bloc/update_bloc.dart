import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../core/params/request_params.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/function_response_model.dart';
import '../../domain/usecases/push_update_usecase.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  PushUpdateRequestParams pushUpdateRequestParams = PushUpdateRequestParams();
  PushUpdateUsecase? pushUpdateUsecase;
  UpdateBloc({required this.pushUpdateUsecase}) : super(UpdateInitial()) {
    on<PushUpdateEvent>(_pushUpdate);
  }
  Future<void> _pushUpdate(
      PushUpdateEvent event, Emitter<UpdateState> emit) async {
    pushUpdateRequestParams.apk = event.apk;
    pushUpdateRequestParams.platform = event.platform;
    pushUpdateRequestParams.version = event.version;

    emit(UpdateLoading());
    dynamic failureOrPosts = await pushUpdateUsecase!(pushUpdateRequestParams);
    await delay(seconds: 2);

    failureOrPosts.fold(
      (failure) {
        print("TitleFailure");
        emit(UpdateFailure());
      },
      (FunctionResponseModel functionResponseModel) {
        // emit(BooksSuccess(
        //   _booksList,
        //   noMoreData,
        // ));
        if (functionResponseModel.error == "0") {
          emit(UpdateSuccess());
        } else {
          emit(UpdateFailure());
        }
      },
    );
    await delay(seconds: 2);
    emit(UpdateInitial());
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
