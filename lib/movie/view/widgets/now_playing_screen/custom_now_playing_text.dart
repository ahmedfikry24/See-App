import 'package:flutter/material.dart';

class CustomNowPlayingText extends StatelessWidget {
  final String text;
  const CustomNowPlayingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
