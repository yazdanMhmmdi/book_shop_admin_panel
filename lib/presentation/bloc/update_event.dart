// ignore_for_file: must_be_immutable

part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class PushUpdateEvent extends UpdateEvent {
  String? platform, version;
  File? apk;
  PushUpdateEvent({this.apk, this.platform, this.version});

  @override
  List<Object> get props => [
        apk!,
        platform!,
        version!,
      ];
}
