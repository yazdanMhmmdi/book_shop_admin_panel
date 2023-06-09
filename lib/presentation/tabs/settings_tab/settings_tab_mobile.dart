import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/update_bloc.dart';
import '../../cubit/settings_validation_cubit.dart';
import '../../widgets/apk_picker/apk_picker_mobile.dart';
import '../../widgets/custom_progress_button.dart';
import '../../widgets/dialogs/update_warning_dialog/update_warning_dialog_mobile.dart';
import '../../widgets/my_button.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/warning_bar/warning_bar_mobile.dart';

class SettingsTabMobile extends StatefulWidget {
  SettingsTabMobile({Key? key}) : super(key: key);

  @override
  State<SettingsTabMobile> createState() => _SettingsTabMobileState();
}

class _SettingsTabMobileState extends State<SettingsTabMobile> {
  TextEditingController _apkVersionController = TextEditingController();

  ButtonState buttonState = ButtonState.idle;

  SettingsValidationCubit? _settingsValidationCubit;
  File? apkFile = File('');
  @override
  void initState() {
    initTab();
    initListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.settingsTabUpdateTitle,
                style: TextStyle(
                  color: IColors.black85,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                Strings.settingsTabUpdateVersion,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: IColors.black85,
                ),
              ),
              textField(Strings.settingsTabUpdateEditFieldHint, 200,
                  _apkVersionController, 14),
              BlocBuilder<SettingsValidationCubit, SettingsValidationState>(
                builder: (context, state) {
                  if (state is SettingsValidationStatus) {
                    return state.versionError!.isNotEmpty
                        ? WarningBarMobile(text: state.versionError!)
                        : Container();
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 32,
              ),
              ApkPickerMobile(
                onApkPicked: (apk) {
                  apkFile = apk;
                  _settingsValidationCubit!.apkValidation(apk: apkFile!);
                },
              ),
              BlocBuilder<SettingsValidationCubit, SettingsValidationState>(
                builder: (context, state) {
                  if (state is SettingsValidationStatus) {
                    return state.apkFileError!.isNotEmpty
                        ? WarningBarMobile(text: state.apkFileError!)
                        : Container();
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        const WidgetSpan(
                          child: SizedBox(width: 8),
                        ),
                        WidgetSpan(
                          child: Image.asset(
                            Assets.attentionSmall,
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const TextSpan(
                          text: Strings.settingsTabWarning,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.orange,
                              decoration: TextDecoration.none,
                              fontFamily: Strings.fontIranSans),
                        ),
                        TextSpan(
                          text: Strings.settingsTabWarningInfo,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: IColors.black35,
                              fontFamily: Strings.fontIranSans),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<UpdateBloc, UpdateState>(
                builder: (context, state) {
                  if (state is UpdateSuccess) {
                    return buttonUI(ButtonState.success, 32);
                  } else if (state is UpdateLoading) {
                    return buttonUI(ButtonState.loading, 32);
                  } else if (state is UpdateFailure) {
                    return buttonUI(ButtonState.fail, 32);
                  } else {
                    return buttonUI(ButtonState.idle, 8);
                  }
                },
              ))
        ],
      ),
    );
  }

  Widget buttonUI(ButtonState buttonState, double borderRadius) {
    return MyButton(
        buttonState: buttonState,
        text: "تایید",
        onTap: () {
          // authBloc!.add(LoginEvent(
          //     password: _passwordController.text,
          //     username: _userController.text));
          _settingsValidationCubit!
              .versionValidation(version: _apkVersionController.text);
          _settingsValidationCubit!.apkValidation(apk: apkFile!);

          if (_settingsValidationCubit!.apkFileError.isEmpty &&
              _settingsValidationCubit!.versionError.isEmpty) {
            ShowDialog.showDialog(
              context,
              BlocProvider.value(
                value: BlocProvider.of<UpdateBloc>(context),
                child: UpdateWarningDialogMobile(
                  onSubmitTap: () {
                    // if (GlobalClass.pickedUserId.toString().isNotEmpty) {

                    BlocProvider.of<UpdateBloc>(context).add(PushUpdateEvent(
                      apk: apkFile,
                      platform: "Android",
                      version: _apkVersionController.text,
                    ));
                    Navigator.pop(context);

                    // }
                  },
                ),
              ),
            );
          }
        });
  }

  Widget textField(
    String hint,
    double width,
    TextEditingController controller,
    maxLengh, {
    Function(String)? onChanged,
    TextInputType? textInputType,
    bool? isOnlyDigit,
    bool threeDigitSeperator = false,
  }) {
    onChanged ??= onChanged = (v) {
      return '';
    };
    textInputType ??= TextInputType.text;
    isOnlyDigit ??= false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 8,
        ),
        Material(
          child: Container(
            height: 48,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller: controller,
                onChanged: onChanged,
                maxLines: 1,
                keyboardType: textInputType,
                inputFormatters: <TextInputFormatter>[
                  threeDigitSeperator
                      ? CurrencyTextInputFormatter(
                          customPattern: customThreeDigitsPattern,
                          decimalDigits: 0,
                        )
                      : FilteringTextInputFormatter.singleLineFormatter,
                  LengthLimitingTextInputFormatter(maxLengh),
                  isOnlyDigit
                      ? FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+\.?[0-9]*'))
                      : FilteringTextInputFormatter.singleLineFormatter,
                ],
                style: const TextStyle(fontFamily: 'IranSans', fontSize: 16),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                        fontFamily: Strings.fontIranSans,
                        fontSize: 16,
                        color: IColors.black55),
                    contentPadding: const EdgeInsets.only(
                        bottom: 16, right: 16, left: 16, top: 16)),
              )),
            ),
          ),
        ),
      ],
    );
  }

  void initTab() {
    _settingsValidationCubit =
        BlocProvider.of<SettingsValidationCubit>(context);
  }

  void initListeners() {
    _apkVersionController.addListener(() {
      _settingsValidationCubit!
          .versionValidation(version: _apkVersionController.text);
    });
  }
}
