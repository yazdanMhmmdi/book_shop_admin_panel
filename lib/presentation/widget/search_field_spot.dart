import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class SearchFieldSpot extends StatefulWidget {
  bool visiblity;
  double opacity;
  SearchFieldSpot({this.visiblity, this.opacity});
  @override
  _SearchFieldSpotState createState() => _SearchFieldSpotState();
}

class _SearchFieldSpotState extends State<SearchFieldSpot> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: widget.opacity,
      child: Visibility(
        visible: widget.visiblity,
        child: Padding(
          padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.search,
                  color: IColors.boldGreen,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "پست مورد نظر را جستجو کنید...",
                  style: TextStyle(
                    fontFamily: "IranSans",
                    fontSize: 14,
                    color: IColors.black35,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
