import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldSpot extends StatefulWidget {
  String title;
  double width;
  int maxLengh;
  String initialValue;
  Function(String) onChanged;
  TextFieldSpot(
      {@required this.title,
      @required this.width,
      @required this.maxLengh,
      @required this.onChanged,
      this.initialValue});

  @override
  _TextFieldSpotState createState() => _TextFieldSpotState();
}

class _TextFieldSpotState extends State<TextFieldSpot> {
  @override
  void initState() {
    print("textField: ${widget.initialValue}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${widget.title}",
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
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller:
                    TextEditingController(text: "${widget.initialValue}"),
                onChanged: widget.onChanged,
                maxLines: 2,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(widget.maxLengh),
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

  @override
  void dispose() {
    widget.initialValue = "";
    super.dispose();
  }
}
