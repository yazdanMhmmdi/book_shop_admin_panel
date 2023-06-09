import '../../widgets/background_shapes/background_shapes_mobile.dart';
import '../../widgets/custom_progress_button.dart';
import '../../widgets/warning_bar/warning_bar_desktop.dart';

import '../../cubit/form_validation_cubit.dart';
import '../../widgets/toast_widget.dart';

import '../../bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../widgets/login_text_field/login_text_field_desktop.dart';
import '../../widgets/my_button.dart';

class LoginPageDesktop extends StatefulWidget {
  LoginPageDesktop({Key? key}) : super(key: key);

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  FormValidationCubit? formValidationCubit;
  ButtonState buttonState = ButtonState.idle;
  var backgroundColor = IColors.green;
  AuthBloc? authBloc;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          await delay(seconds: 2);
          Navigator.pushNamed(context, '/panelpage');
        } else if (state is AuthFailure) {
          ToastWidget.showError(context,
              title: "خطا", desc: "نام کاربری یا رمز عبور اشتباه است");
        }
      },
      child: Scaffold(
        backgroundColor: IColors.green,
        body: Stack(
          children: [
            const BackgroundShapesMobile(),
            Center(
              child: Container(
                width: 348,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(-1, 0),
                        blurRadius: 3,
                        color: IColors.black15,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 26,
                      ),
                      Text(
                        "ورود ادمین",
                        style: TextStyle(
                            fontFamily: Strings.fontIranSans,
                            fontSize: 18,
                            color: IColors.black85,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      LoginTextFieldDesktop(
                        obscureText: false,
                        lengthLimiting: 20,
                        iconData: Icons.person,
                        hintText: "نام کاربری...",
                        textEditingController: _usernameController,
                      ),
                      BlocBuilder<FormValidationCubit, FormValidationState>(
                        builder: (context, state) {
                          return state.isUsernameValid!
                              ? Container()
                              : WarningBarDesktop(
                                  text: "نام کاربری اشتباه است");
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      LoginTextFieldDesktop(
                        obscureText: true,
                        iconData: Icons.lock,
                        lengthLimiting: 12,
                        hintText: "رمزعبور...",
                        textEditingController: _passwordController,
                      ),
                      BlocBuilder<FormValidationCubit, FormValidationState>(
                        builder: (context, state) {
                          return state.isPasswordValid!
                              ? Container()
                              : WarningBarDesktop(text: "رمز عبور اشتباه است");
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return buttonUI(ButtonState.success, 32, 50);
                          } else if (state is AuthLoading) {
                            return buttonUI(ButtonState.loading, 32, 50);
                          } else if (state is AuthFailure) {
                            return buttonUI(ButtonState.fail, 32, 50);
                          } else {
                            return buttonUI(ButtonState.idle, 8, 50);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
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

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  Widget buttonUI(
      ButtonState buttonState, double borderRadius, double minWidth) {
    return MyButton(
        buttonState: buttonState,
        text: "تایید",
        onTap: () {
          formValidationCubit!.usernameValidate(_usernameController!.text);
          formValidationCubit!.passwordValidate(_passwordController!.text);

          if (formValidationCubit!.state.isUsernameValid! &&
              formValidationCubit!.state.isPasswordValid!) {
            authBloc!.add(LoginEvent(
                password: _passwordController!.text,
                username: _usernameController!.text));
          }
        });
  }

  initPage() {
    authBloc = BlocProvider.of<AuthBloc>(context);

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    authBloc = BlocProvider.of<AuthBloc>(context);
    formValidationCubit = BlocProvider.of<FormValidationCubit>(context);

    _usernameController!.addListener(() {
      formValidationCubit!.usernameValidate(_usernameController!.text);
      print(
          "usernmame : ${_usernameController!.text}, ${_passwordController!.text}");
    });
    _passwordController!.addListener(() {
      formValidationCubit!.passwordValidate(_passwordController!.text);
      print(
          "password : ${_usernameController!.text}, ${_passwordController!.text}");
    });
  }
}
