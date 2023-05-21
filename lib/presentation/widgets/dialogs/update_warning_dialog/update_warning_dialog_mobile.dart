import '../../../bloc/users_bloc.dart';
import '../../global_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/i_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../bloc/books_bloc.dart';

class UpdateWarningDialogMobile extends StatefulWidget {
  Function onSubmitTap;
  UpdateWarningDialogMobile({required this.onSubmitTap});
  @override
  _UpdateWarningDialogMobileState createState() => _UpdateWarningDialogMobileState();
}

class _UpdateWarningDialogMobileState extends State<UpdateWarningDialogMobile> {
  bool isAnyBookSelected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 392,
      height: 228,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, -1),
              blurRadius: 4,
              spreadRadius: 0,
              color: IColors.black15,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Container(
              width: 67,
              height: 67,
              child: Image.asset(Assets.attention),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                Strings.updateDialogText,
                textAlign: TextAlign.center,
                
                style: TextStyle(
                  height: 1.8,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: IColors.black85,
                    fontFamily: Strings.fontIranSans,
                    decoration: TextDecoration.none),
              ),
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    width: 165,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: IColors.boldGreen,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.black12,
                        onTap: () => widget.onSubmitTap.call(),
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                          child: Text(
                            'تایید',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: Strings.fontIranSans,
                              fontSize: 16,
                              color: Colors.white70,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                     width: 165,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: IColors.black25,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.black12,
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                          child: Text(
                            'انصراف',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: Strings.fontIranSans,
                              fontSize: 16,
                              color: Colors.white70,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
