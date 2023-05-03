part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailStatus extends DetailState {
  var maxBorderRadius = 50.0;
  var borderRadius = 50.0;
  var percent = 1.0;
  double draggableSize = 0.75;

  DetailStatus(
      {required this.maxBorderRadius,
      required this.borderRadius,
      required this.draggableSize,
      required this.percent});

  @override
  List<Object> get props => [
        this.maxBorderRadius,
        this.borderRadius,
        this.borderRadius,
        this.draggableSize,
        this.percent
      ];
}
