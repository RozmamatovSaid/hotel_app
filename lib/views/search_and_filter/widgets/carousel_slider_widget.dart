import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key, required this.imageList});
  final List imageList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.ease,
      ),
      items:
          imageList.map((url) {
            return Builder(
              builder:
                  (context) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(imageUrl: url),
                  ),
            );
          }).toList(),
    );
  }
}
