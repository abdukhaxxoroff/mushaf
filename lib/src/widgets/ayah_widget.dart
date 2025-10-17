import 'package:flutter/material.dart';
import 'package:mushaf/mushaf.dart';

class AyahWidget extends StatelessWidget {
  const AyahWidget(this.ayah, {super.key});

  final Ayah ayah;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children:
          ayah.ayah.split(' ').map((word) => TextSpan(text: word)).toList(),
      style: Mushaf().hafsStyle,
    ));
  }
}
