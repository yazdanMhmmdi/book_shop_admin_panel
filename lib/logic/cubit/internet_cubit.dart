import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected();
        print('internet Connected');
      } else {
        emitInternetDisconnected();
        print('internet Disconnected');
      }
    });
  }

  void emitInternetConnected() {
    emit(InternetConnected());
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
