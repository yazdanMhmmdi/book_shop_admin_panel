import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class DeleteBookDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 492,
      height: 240,
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
                "آیا شما مطمئن هستید؟  ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: IColors.black85,
                    fontFamily: "IranSans",
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
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            'تایید',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "IranSans",
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
                SizedBox(
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
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            'انصراف',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "IranSans",
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