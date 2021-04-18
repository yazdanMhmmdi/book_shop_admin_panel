import 'dart:async';

import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/login_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/background_shapes.dart';
import 'package:book_shop_admin_panel/presentation/widget/login_text_field.dart';
import 'package:book_shop_admin_panel/presentation/widget/my_button.dart';
import 'package:book_shop_admin_panel/presentation/widget/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  ButtonState buttonState = ButtonState.idle;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      cubit: _loginBloc,
      listener: (context, state) {
        if (state is LoginInitial) {}
        if (state is LoginSuccess) {
          setState(() {
            buttonState = ButtonState.success;
          });
          Timer(Duration(seconds: 2), () {
            Navigator.pushNamed(context, '/panel');
          });
        } else if (state is LoginFailure) {
          setState(() {
            buttonState = ButtonState.fail;
          });
        } else if (state is LoginLoading) {
          setState(() {
            buttonState = ButtonState.loading;
          });
        }
      },
      child: Scaffold(
        backgroundColor: IColors.green,
        body: Stack(
          children: [
            BackgroundShapes(),
            Center(
              child: Container(
                width: 348,
                height: 256,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, 0),
                        blurRadius: 3,
                        color: IColors.black15,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 26,
                      ),
                      Text(
                        "ورود ادمین",
                        style: TextStyle(
                            fontFamily: "IranSans",
                            fontSize: 18,
                            color: IColors.black85,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      LoginTextField(
                        hintText: "نام کاربری...",
                        textEditingController: _userController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      LoginTextField(
                        hintText: "رمزعبور...",
                        textEditingController: _passwordController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MyButton(
                          text: "تایید",
                          onTap: () {
                            _loginBloc.add(LogUserInEvent(
                                username: _userController.text,
                                password: _passwordController.text));
                          },
                          buttonState: buttonState,
                          
                          )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
