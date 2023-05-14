import 'package:book_shop_admin_panel/presentation/widgets/background_shapes/background_shapes_mobile.dart';

import '../../widgets/login_text_field/login_text_field_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/i_colors.dart';
import '../../animations/fade_in_animation.dart';
import '../../bloc/auth_bloc.dart';
import '../../cubit/form_validation_cubit.dart';
import '../../widgets/background_shapes/background_shapes_desktop.dart';
import '../../widgets/my_button.dart';
import '../../widgets/progress_button.dart';
import '../../widgets/toast_widget.dart';
import '../../widgets/warning_bar/warning_bar_mobile.dart';

class LoginPageMobile extends StatelessWidget {
  LoginPageMobile({Key? key}) : super(key: key);
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late String id;
  ButtonState buttonState = ButtonState.idle;
  Color backgroundColor = IColors.green;
  late AuthBloc _authBloc;
  late FormValidationCubit _formValidationCubit;

  @override
  Widget build(BuildContext context) {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _authBloc = BlocProvider.of<AuthBloc>(context);
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);

    _usernameController.addListener(() {
      _formValidationCubit.usernameValidate(_usernameController.text);
      print(
          "usernmame : ${_usernameController.text}, ${_passwordController.text}");
    });
    _passwordController.addListener(() {
      _formValidationCubit.passwordValidate(_passwordController.text);
      print(
          "password : ${_usernameController.text}, ${_passwordController.text}");
    });
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              await delay(seconds: 2);
              Navigator.pushNamed(context, '/categorypage');
            } else if (state is AuthFailure) {
              ToastWidget.showError(context, title: "خطا", desc: state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: IColors.green,
        body: SafeArea(
          child: Stack(
            children: [
              const BackgroundShapesMobile(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FadeInAnimation(
                    1,
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(-1, 0),
                                  blurRadius: 3,
                                  color: const Color(0xff000000)
                                      .withOpacity(0.10)),
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 23),
                            const Text(
                              "ورود ادمین",
                              style: TextStyle(
                                  fontFamily: "IranSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 16),
                            LoginTextFieldMobile(
                                icon: Icons.person,
                                text: "نام کاربری...",
                                obscureText: false,
                                textFieldColor: IColors.lowBoldGreen,
                                controller: _usernameController),
                            BlocBuilder<FormValidationCubit,
                                FormValidationState>(
                              builder: (context, state) {
                                return state.isUsernameValid!
                                    ? Container()
                                    : WarningBarMobile(
                                        text: "نام کاربری اشتباه است");
                              },
                            ),
                            const SizedBox(height: 16),
                            LoginTextFieldMobile(
                                icon: Icons.lock,
                                text: "رمزعبور...",
                                obscureText: true,
                                textFieldColor: IColors.lowBoldGreen,
                                controller: _passwordController),
                            BlocBuilder<FormValidationCubit,
                                FormValidationState>(
                              builder: (context, state) {
                                return state.isPasswordValid!
                                    ? Container()
                                    : WarningBarMobile(
                                        text: "رمز عبور اشتباه است");
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthInitial) {
                                      return buttonUI(ButtonState.idle);
                                    } else if (state is AuthLoading) {
                                      return buttonUI(ButtonState.loading);
                                    } else if (state is AuthSuccess) {
                                      return buttonUI(ButtonState.success);
                                    } else if (state is AuthFailure) {
                                      return buttonUI(ButtonState.fail);
                                    } else {
                                      return Container();
                                    }
                                  },
                                )),
                            const SizedBox(height: 16),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonUI(ButtonState buttonState) {
    return MyButton(
        buttonState: buttonState,
        text: "تایید",
        onTap: () {
          // setState(() {
          //   _buttonState = ButtonState.loading;
          // });
          _authBloc.add(LoginEvent(
              username: _usernameController.text,
              password: _passwordController.text));
        });
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
