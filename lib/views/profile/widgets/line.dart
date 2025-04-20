import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            226,
            217,
            217,
          ),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}
