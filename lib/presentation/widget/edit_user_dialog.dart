import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/data/model/users_model.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserDialog extends StatefulWidget {
  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  TextEditingController _usernameController = new TextEditingController();

  TextEditingController _passwordController = new TextEditingController();
  UsersBloc _usersBloc;
  String user_id;
  @override
  void initState() {
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _usersBloc.add(ReturnSelectedEvent());
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
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is ReturnSelectedUser) {
              user_id = state.user_id;
              return objects(state);
            } else if (state is UsersFailure) {
              return Container();
            } else if (state is UsersSuccess) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget objects(dynamic state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        textField(
            "نام کاربری", 660, _usernameController..text = state.username, 20),
        textField(
            "رمز عبور", 660, _passwordController..text = state.password, 20),
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
                _usersBloc.add(EditUsersEvent(
                    user_id: user_id,
                    username: _usernameController.text,
                    password: _passwordController.text));
                _usersBloc.add(DisposeUsersEvent());
                _usersBloc.add(GetUsersEvent());
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  "ویرایش کاربر",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "IranSans",
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
              fontFamily: "IranSans",
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
                style: TextStyle(fontFamily: 'IranSans', fontSize: 16),
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
