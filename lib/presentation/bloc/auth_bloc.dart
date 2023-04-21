import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/auth_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../widgets/global_class.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthLoginRequestParams authLoginRequestParams = AuthLoginRequestParams();
  LoginUsecase loginUsecase;
  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    authLoginRequestParams.username = event.username!;
    authLoginRequestParams.password = event.password!;

    emit(AuthLoading());
    dynamic failureOrPosts = await loginUsecase(authLoginRequestParams);
    await delay(seconds: 2);

    failureOrPosts.fold(
      (failure) async {
        if (failure is WrongAuthFailure) {
          emit(AuthFailure(message: failure.message!));
        }
      },
      (AuthModel authModel) {
        if (authModel.error == "0") {
          GlobalClass.pickedUserId = int.parse(authModel.userId!);
          emit(AuthSuccess());
        }
      },
    );
    await delay(seconds: 2);
    emit(AuthInitial());
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
