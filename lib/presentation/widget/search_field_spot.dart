import 'dart:async';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/image_picker_spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldSpot extends StatefulWidget {
  bool visiblity;
  double opacity;
  int maxLengh;

  Stream searchState;
  SearchFieldSpot({this.visiblity, this.opacity, this.maxLengh});
  @override
  _SearchFieldSpotState createState() => _SearchFieldSpotState();
}

class _SearchFieldSpotState extends State<SearchFieldSpot> {
  final TextEditingController controller = new TextEditingController();
  BookBloc _bookBloc;
  bool iconStatus; //true : X, false: search
  @override
  void initState() {
    _bookBloc = BlocProvider.of<BookBloc>(context);
    super.initState();
  }

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
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                IconButton(
                  icon: Icon(iconStatus == true ? Icons.close : Icons.search),
                  color: IColors.boldGreen,
                  onPressed: () {
                    _bookBloc.add(DisposeBookEvent());
                    _bookBloc.add(GetBookEvent());
                    controller.clear();

                    setState(() {
                      iconStatus = false;
                    });
                  },
                ),
                Container(
                  height: 43,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          maxLines: 3,
                          onChanged: (val) {
                            if (val != "") {
                              setState(() {
                                iconStatus = true;
                              });
                            } else {
                              setState(() {
                                iconStatus = false;
                              });
                            }
                            _bookBloc.add(DisposeBookEvent());
                            _bookBloc.add(SearchBookEvent(
                                category_id: "1",
                                search: val,
                                isLazyLoad: false));
                          },
                          controller: controller,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(widget.maxLengh),
                          ],
                          style:
                              TextStyle(fontFamily: 'IranSans', fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "نام کتاب را جستجو کنید...",
                            hintStyle:
                                TextStyle(fontFamily: 'IranSans', fontSize: 16),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              top: 11,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
