import 'package:book_shop_admin_panel/presentation/widget/title_selector.dart';
import 'package:flutter/material.dart';

int tabNumber = 1; 

class CustomTabSlider extends StatefulWidget {
  @override
  _CustomTabSliderState createState() => _CustomTabSliderState();
}

class _CustomTabSliderState extends State<CustomTabSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right:65),
              child: TitleSelector(titles: ["کتابها", "کاربران"], firstTab: 1),
            )
          ],
        ),
      ),
    );
  }
}
