import 'dart:io';

import 'package:book_shop_admin_panel/core/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/bloc/update_bloc.dart';
import 'package:book_shop_admin_panel/presentation/cubit/settings_validation_cubit.dart';
import 'package:book_shop_admin_panel/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop_admin_panel/presentation/widgets/dialogs/update_warning_dialog/update_warning_dialog_desktop.dart';
import 'package:book_shop_admin_panel/presentation/widgets/edit_text_field.dart';
import 'package:book_shop_admin_panel/presentation/widgets/main_panel.dart';
import 'package:book_shop_admin_panel/presentation/widgets/side_bar.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/users_bloc.dart';
import '../../widgets/apk_picker/apk_picker_desktop.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/toast_widget.dart';
import '../../widgets/warning_bar/warning_bar_desktop.dart';

class SettingsTabDesktop extends StatefulWidget {
  SettingsTabDesktop({Key? key}) : super(key: key);

  @override
  State<SettingsTabDesktop> createState() => _SettingsTabDesktopState();
}

class _SettingsTabDesktopState extends State<SettingsTabDesktop> {
  TextEditingController _appVersionController = TextEditingController();

  File apkFile = File('');
  SettingsValidationCubit? _settingsValidationCubit;
  @override
  void initState() {
    initTab();
    initListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        switchCaseToasting(state);
      },
      child: Row(
        children: [
          SideBar(
            children: [],
          ),
          MainPanel(
              child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.settingsTabUpdateTitle,
                          style: TextStyle(
                            fontSize: 20,
                            color: IColors.black85,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.settingsTabUpdateVersion,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: IColors.black85,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                textField(
                                    Strings.settingsTabUpdateEditFieldHint,
                                    185,
                                    _appVersionController,
                                    14),
                              ],
                            ),
                            const SizedBox(
                              width: 23,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.settingsTabUpdatePickFile,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: IColors.black85,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ApkPickerDesktop(
                                  onApkPicked: (apk) {
                                    apkFile = apk;
                                    _settingsValidationCubit!
                                        .apkValidation(apk: apkFile);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 23,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: myButton(context),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 160,
                                child: BlocBuilder<SettingsValidationCubit,
                                    SettingsValidationState>(
                                  builder: (context, state) {
                                    if (state is SettingsValidationStatus) {
                                      return state.versionError!.isNotEmpty
                                          ? WarningBarDesktop(
                                              text: state.versionError!)
                                          : Container();
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              BlocBuilder<SettingsValidationCubit,
                                  SettingsValidationState>(
                                builder: (context, state) {
                                  if (state is SettingsValidationStatus) {
                                    return state.apkFileError!.isNotEmpty
                                        ? WarningBarDesktop(
                                            text: state.apkFileError!)
                                        : Container();
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.attentionSmall,
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(Strings.settingsTabWarning,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.normal)),
                            Text(
                              Strings.settingsTabWarningInfo,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: IColors.black35,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
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

  Widget myButton(BuildContext context) {
    return Container(
      width: 70,
      height: 48,
      decoration: BoxDecoration(
        color: IColors.boldGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _settingsValidationCubit!
                .versionValidation(version: _appVersionController.text);
            _settingsValidationCubit!.apkValidation(apk: apkFile);

            if (_settingsValidationCubit!.versionError == "" &&
                _settingsValidationCubit!.apkFileError == "") {
              ShowDialog.showDialog(
                context,
                BlocProvider.value(
                  value: BlocProvider.of<UpdateBloc>(context),
                  child: UpdateWarningDialogDesktop(
                    onSubmitTap: () {
                      // if (GlobalClass.pickedUserId.toString().isNotEmpty) {

                      BlocProvider.of<UpdateBloc>(context).add(PushUpdateEvent(
                        apk: apkFile,
                        platform: "Android",
                        version: _appVersionController.text,
                      ));
                      Navigator.pop(context);

                      // }
                    },
                  ),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: const Center(
            child: Text(
              "ارسال",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initTab() {
    _settingsValidationCubit =
        BlocProvider.of<SettingsValidationCubit>(context);
  }

  void initListeners() {
    _appVersionController.addListener(() {
      _settingsValidationCubit!
          .versionValidation(version: _appVersionController.text);
    });
  }

  switchCaseToasting(UpdateState state) {
    //swtich/case Toasting
    switch (state.runtimeType) {
      case UpdateSuccess:
        ToastWidget.showSuccess(context,
            title: Strings.settingsTabSuccess,
            desc: Strings.settingsTabSuccessDesc);

        break;
      case UpdateFailure:
        ToastWidget.showSuccess(context,
            title: Strings.settingsTabFailure,
            desc: Strings.settingsTabFailureDesc);
        break;
      default:
    }
  }
}
