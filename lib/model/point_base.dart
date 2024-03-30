import 'package:flutter/material.dart';

class PointBase {
  final int x;
  final int y;
  final int brightness;
  final double size;
  final Color color;
  final double angle;
  PointBase({
    required this.x,
    required this.y,
    required this.brightness,
    required this.size,
    required this.color,
    required this.angle,
  });
}
