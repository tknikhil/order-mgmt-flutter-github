import 'package:flutter/material.dart';

class Palette{
  Palette._();

  static const Color white = Color(0xffffffff);
  static const Color gold=Color(0xffB78727);
  static const Color text=Color(0xffb76734);

  static const BoxDecoration backgroundGradient= BoxDecoration(
      gradient: RadialGradient(
        colors: [Palette.white,Palette.gold, ],
        radius: 0.90,
        focal: Alignment(0.9, -0.7),
        tileMode: TileMode.clamp,
      ));
}