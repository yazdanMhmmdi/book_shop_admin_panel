import 'dart:math';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderObject extends StatefulWidget {
  String coverType, voteCount, pageCount, language;
  SliderObject(
      {@required this.coverType,
      @required this.voteCount,
      @required this.pageCount,
      @required this.language});
  @override
  _SliderObjectState createState() => _SliderObjectState();
}

class _SliderObjectState extends State<SliderObject> {
  // slider Animation
  Color _sliderLeftTextColor = Colors.black38;
  Color _sliderRightTextColor = Colors.black87;
  int _sliderTextDuration = 350;
  AlignmentGeometry _sliderObjectAlignment = Alignment.centerRight;
  CarouselController _pageCarouselController = CarouselController();
  Random _random = new Random();
  int _randAge, _randBookCount, _randCategory, _randVote;
  @override
  void initState() {
    _randAge = _random.nextInt(90);
    _randBookCount = _random.nextInt(20);
    _randCategory = _random.nextInt(5);
    _randVote = _random.nextInt(5);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    sliderAnimationRightClicked();
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: _sliderTextDuration),
                    child: Text(
                      "درباره کتاب",
                    ),
                    style: TextStyle(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _sliderRightTextColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                sliderAnimationLeftClicked();
              },
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: _sliderTextDuration),
                child: Text(
                  "درباره ناشر",
                ),
                style: TextStyle(
                  fontFamily: Strings.fontIranSans,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _sliderLeftTextColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: _sliderTextDuration),
              alignment: _sliderObjectAlignment,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 58,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: IColors.boldGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        AbsorbPointer(
          child: CarouselSlider(
            carouselController: _pageCarouselController,
            options: CarouselOptions(
                onPageChanged: null,
                disableCenter: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
                height: 97,
                viewportFraction: 1,
                initialPage: 1,
                enableInfiniteScroll: false),
            items: [
              objectSliderItem(
                  "سن",
                  _randAge.toString(),
                  "تعداد کتاب",
                  (_randBookCount.toString() + " جلد "),
                  "دسته بندی",
                  _randCategory.toString(),
                  "مجموع آرا",
                  (_randVote.toString())),
              objectSliderItem("زبان", widget.language, "جلد", widget.coverType,
                  "صفحه", widget.pageCount, "رای", widget.voteCount),
            ],
          ),
        ),
      ],
    );
  }

  void sliderAnimationLeftClicked() {
    setState(() {
      _sliderLeftTextColor = Colors.black87;
      _sliderRightTextColor = Colors.black38;
      _sliderObjectAlignment = Alignment.centerLeft;
      _pageCarouselController.previousPage(
          duration: Duration(milliseconds: _sliderTextDuration));
    });
  }

  void sliderAnimationRightClicked() {
    setState(() {
      _sliderLeftTextColor = Colors.black38;
      _sliderRightTextColor = Colors.black87;
      _sliderObjectAlignment = Alignment.centerRight;
      _pageCarouselController.nextPage(
          duration: Duration(milliseconds: _sliderTextDuration));
    });
  }

  Widget objectSliderItem(
      String first,
      String second,
      String third,
      String fourth,
      String fifth,
      String sixth,
      String seventh,
      String eighth) {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: IColors.boldGreen.withOpacity(0.15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                littleDialogBox("${second}", "$first"),
                littleDialogBox("${fourth}", "$third"),
                littleDialogBox("${sixth}", "$fifth"),
                littleDialogBox("${eighth}", "$seventh")
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget littleDialogBox(String title, String subTitle) {
    return Column(
      children: [
        Text(
          '$title',
          style: TextStyle(
            fontFamily: Strings.fontIranSans,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          '$subTitle',
          style: TextStyle(
            fontFamily: Strings.fontIranSans,
            fontSize: 18,
            color: Colors.black38,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        )
      ],
    );
  }
}
