import 'package:book_shop_admin_panel/core/constants/constants.dart';
import 'package:book_shop_admin_panel/core/utils/map_rule_types.dart';
import 'package:book_shop_admin_panel/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/users_bloc.dart';
import '../custom_dropdown_widget.dart';

class EditUserDialog extends StatefulWidget {
  UserModel userModel;
  EditUserDialog({required this.userModel});
  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  TextEditingController _usernameController = new TextEditingController();
  String? _coverType = ruleTypes[1]["title"]!;

  TextEditingController _passwordController = new TextEditingController();
  UsersBloc? _usersBloc;
  @override
  void initState() {
    _usersBloc = BlocProvider.of<UsersBloc>(context);
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
        textField("نام کاربری", 660,
            _usernameController..text = userModel.username!, 20),
        Wrap(

          verticalDirection: VerticalDirection.up,
          children: [
            CustomDropdownWidget(
                selectedValueChange: (val) {
                  _coverType = val;
                },
                title: "نقش",
                selectedValue: _coverType = userModel.ruleType!,
                width: 130,
                optionList: [
                  ruleTypes[0]['title']!,
                  ruleTypes[1]['title']!,
                ]),
            SizedBox(
              width: 16,
            ),
            textField("رمز عبور", 510,
                _passwordController..text = userModel.password!, 20),
          ],
        ),
        SizedBox(
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
                _usersBloc!.add(EditUsersEvent(
                    userId: userModel.id!,
                    username: _usernameController.text,
                    password: _passwordController.text));

                _usersBloc!.add(GetUsersEvent());
                Navigator.pop(context);
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
}