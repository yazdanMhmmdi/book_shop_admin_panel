import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_validation_state.dart';

class SettingsValidationCubit extends Cubit<SettingsValidationState> {
  String versionError = "", apkFileError = "";

  SettingsValidationCubit() : super(SettingsValidationStatus());

  void versionValidation({String? version}) {
    if (version!.isEmpty) {
      versionError = "ورژن نمی تواند خالی باشد";
    } else {
      versionError = "";
    }
    emit(SettingsValidationStatus(
      versionError: versionError,
      apkFileError: apkFileError,
    ));
  }

  void apkValidation({required File apk}) {
    if (apk.path.isEmpty) {
      apkFileError = "فایل نصبی اپلیکیشن نمی تواند خالی باشد";
    } else {
      apkFileError = "";
    }
    emit(SettingsValidationStatus(
      versionError: versionError,
      apkFileError: apkFileError,
    ));
  }
}
