// ignore_for_file: must_be_immutable

part of 'settings_validation_cubit.dart';

abstract class SettingsValidationState extends Equatable {
  const SettingsValidationState();

  @override
  List<Object> get props => [];
}

class SettingsValidationStatus extends SettingsValidationState {
  String? versionError, apkFileError;

  SettingsValidationStatus({this.versionError = "", this.apkFileError = ""});

  @override
  List<Object> get props => [
        apkFileError!,
        versionError!,
      ];
}
