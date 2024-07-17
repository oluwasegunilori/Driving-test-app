import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

const double strokeWidth = 3.5;

class CirclePainter extends CustomPainter {
  final Size whiteSize;
  final BuildContext buildContext;
  CirclePainter({required this.whiteSize, required this.buildContext});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final primaryPaint = Paint()
      ..color = Theme.of(buildContext).colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    // Draw the full circle with red color
    canvas.drawCircle(center, radius, paint);

    // Define the starting and ending angle for the white arc
    double startAngle = -pi / 2; // Starting from the top
    double sweepAngle =
        2 * pi * ((whiteSize.height) / 100); // Covering 25% of the circle

    // Draw the white arc over the red circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      primaryPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
