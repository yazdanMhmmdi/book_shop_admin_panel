// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/i_colors.dart';
import '../../../../core/constants/strings.dart';

class UpdateWarningDialogDesktop extends StatefulWidget {
  Function onSubmitTap;
  UpdateWarningDialogDesktop({required this.onSubmitTap});
  @override
  _UpdateWarningDialogDesktopState createState() => _UpdateWarningDialogDesktopState();
}

class _UpdateWarningDialogDesktopState extends State<UpdateWarningDialogDesktop> {
  bool isAnyBookSelected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 492,
      height: 275,
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
              width: 87,
              height: 87,
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
                    fontSize: 16,
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
                    width: 212,
                    height: 40,
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
                    width: 212,
                    height: 40,
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
