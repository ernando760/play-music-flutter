import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AnimatedTitleMediaWidget extends StatelessWidget {
  const AnimatedTitleMediaWidget(
      {super.key,
      required this.title,
      this.style,
      this.textAlign,
      this.aspectRatio});
  final String title;
  final TextStyle? style;
  final double? aspectRatio;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final CarouselController carouselController = CarouselController();
    return IgnorePointer(
      child: CarouselSlider(
          carouselController: carouselController,
          items: [
            Text(
              title,
              textAlign: textAlign ?? TextAlign.center,
              style: style ??
                  TextStyle(
                      fontSize: title.length >= 15 ? 20 : 26,
                      fontWeight: FontWeight.bold),
            ),
          ],
          disableGesture: true,
          options: CarouselOptions(
            initialPage: 0,
            aspectRatio: aspectRatio ?? 6 / .5,
            autoPlay: true,
            disableCenter: false,
            viewportFraction: 1,
            autoPlayCurve: Curves.linear,
            autoPlayAnimationDuration: const Duration(seconds: 5),
            autoPlayInterval: const Duration(seconds: 7),
          )),
    );
  }
}
