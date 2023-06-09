// ignore_for_file: must_be_immutable

import '../../cubit/user_validation_cubit.dart';
import '../warning_bar/warning_bar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/users_bloc.dart';
import '../custom_dropdown_widget.dart';

class EditUserDialogDesktop extends StatefulWidget {
  UserModel userModel;
  EditUserDialogDesktop({super.key, required this.userModel});
  @override
  _EditUserDialogDesktopState createState() => _EditUserDialogDesktopState();
}

class _EditUserDialogDesktopState extends State<EditUserDialogDesktop> {
  TextEditingController _usernameController = TextEditingController();
  String? _ruleType = ruleTypes[1]["title"]!;

  TextEditingController _passwordController = TextEditingController();
  UsersBloc? _usersBloc;
  UserValidationCubit? _userValidationCubit;
  @override
  void initState() {
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _userValidationCubit = BlocProvider.of<UserValidationCubit>(context);

    initListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, -1),
              blurRadius: 4,
              spreadRadius: 0,
              color: IColors.black15,
            ),
          ]),
      child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: objects(widget.userModel)),
    );
  }

  Widget objects(UserModel userModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            textField("نام کاربری", 660,
                _usernameController..text = userModel.username!, 20),
            SizedBox(
              width: 660,
              child: BlocBuilder<UserValidationCubit, UserValidationState>(
                builder: (context, state) {
                  if (state is UserValidationStatus) {
                    return state.username.isNotEmpty
                        ? WarningBarDesktop(text: state.username)
                        : Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        Wrap(
          verticalDirection: VerticalDirection.up,
          children: [
            CustomDropdownWidget(
                selectedValueChange: (val) {
                  _ruleType = val;
                },
                title: "نقش",
                selectedValue: _ruleType = userModel.ruleType!,
                width: 130,
                optionList: [
                  ruleTypes[0]['title']!,
                  ruleTypes[1]['title']!,
                ]),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textField("رمز عبور", 510,
                    _passwordController..text = userModel.password!, 20),
                SizedBox(
                  width: 260,
                  child: BlocBuilder<UserValidationCubit, UserValidationState>(
                    builder: (context, state) {
                      if (state is UserValidationStatus) {
                        return state.password.isNotEmpty
                            ? WarningBarDesktop(text: state.password)
                            : Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 38,
          width: 660,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: IColors.boldGreen,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black26,
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (_userValidationCubit!.passwordError.isEmpty &&
                    _userValidationCubit!.usernameError.isEmpty) {
                  _usersBloc!.add(EditUsersEvent(
                      userId: userModel.id!,
                      username: _usernameController.text,
                      password: _passwordController.text,
                      ruleType: _ruleType));

                  _usersBloc!.add(GetUsersEvent());
                  Navigator.pop(context);
                }
              },
              child: const Center(
                child: Text(
                  "ویرایش کاربر",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: Strings.fontIranSans,
                      fontSize: 16,
                      color: Colors.white70,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget textField(
      String title, double width, TextEditingController controller, maxLengh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          child: Container(
            height: 35,
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
                onChanged: (val) {
                  // //widget.onChanged(val);
                  // //widget.onChanged(val);
                  // setState(() {
                  //   controller.text = val;
                  // });
                },
                maxLines: 2,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(maxLengh),
                ],
                style:
                    TextStyle(fontFamily: Strings.fontIranSans, fontSize: 16),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 4, right: 16, left: 16)),
              )),
            ),
          ),
        ),
      ],
    );
  }

  void initListeners() {
    _usernameController.addListener(() {
      _userValidationCubit!.usernameValidation(_usernameController.text);
    });
    _passwordController.addListener(() {
      _userValidationCubit!.passwrodValidation(_passwordController.text);
    });
  }
}
