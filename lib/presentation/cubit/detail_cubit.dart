import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  final maxBorderRadius = 50.0;
  var borderRadius = 50.0;
  var percent = 1.0;
  double draggableSize = 0.75;

  void initializeAnimations(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      draggableSize = 0.75;
    } else {
      draggableSize = 0.75;
    }
    emit(DetailStatus(
      borderRadius: borderRadius,
      draggableSize: draggableSize,
      maxBorderRadius: maxBorderRadius,
      percent: percent,
    ));
  }

  void noto(DraggableScrollableNotification notification) {
    borderRadius = maxBorderRadius -
        ((50 / (1.0 - draggableSize)) * (notification.extent - draggableSize));
    percent = 1.0 -
        _dp(
            ((100.0 / (1.0 - draggableSize)) *
                    (notification.extent - draggableSize)) /
                100,
            2);
    emit(DetailStatus(
      borderRadius: borderRadius,
      draggableSize: draggableSize,
      maxBorderRadius: maxBorderRadius,
      percent: percent,
    ));
  }

  double _dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
