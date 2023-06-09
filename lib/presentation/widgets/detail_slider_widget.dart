// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/i_colors.dart';
import 'detail_slider_container.dart';

class DetailSliderWidget extends StatefulWidget {
  Duration duration;
  List<DetailSliderContainer> sliderContainers;
  DetailSliderWidget({super.key, 
    required this.sliderContainers,
    this.duration = const Duration(milliseconds: kAnimationDuration),
  });
  @override
  _SliderObjectState createState() => _SliderObjectState();
}

class _SliderObjectState extends State<DetailSliderWidget> {
  // slider Animation
  Color _sliderLeftTextColor = Colors.black38;
  Color _sliderRightTextColor = Colors.black87;
  AlignmentGeometry _sliderObjectAlignment = Alignment.centerRight;
  CarouselController _pageCarouselController = CarouselController();
  @override
  void initState() {
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
                    duration: widget.duration,
                    child: const Text(
                      "جزئیات کتاب",
                    ),
                    style: TextStyle(
                        fontFamily: "iranSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _sliderRightTextColor),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                sliderAnimationLeftClicked();
              },
              child: AnimatedDefaultTextStyle(
                duration: widget.duration,
                child: const Text(
                  "درباره ناشر",
                ),
                style: TextStyle(
                    fontFamily: "iranSans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _sliderLeftTextColor),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            AnimatedAlign(
              duration: widget.duration,
              alignment: _sliderObjectAlignment,
              curve: Curves.ease,
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
        const SizedBox(
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
                height: 90,
                autoPlayCurve: Curves.ease,
                viewportFraction: 1,
                initialPage: 1,
                enableInfiniteScroll: false),
            items: widget.sliderContainers,
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
          duration: widget.duration, curve: Curves.ease);
    });
  }

  void sliderAnimationRightClicked() {
    setState(() {
      _sliderLeftTextColor = Colors.black38;
      _sliderRightTextColor = Colors.black87;
      _sliderObjectAlignment = Alignment.centerRight;
      _pageCarouselController.nextPage(
          duration: widget.duration, curve: Curves.ease);
    });
  }
}
