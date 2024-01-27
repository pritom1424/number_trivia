import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBar extends CustomPainter {
  final double sWidth;
  final double percent;
  final Color progressColor;
  CircleProgressBar(this.sWidth, this.percent, this.progressColor);
  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = sWidth
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radius = 100;
    canvas.drawCircle(center, radius, circle);

    Paint animationArc = Paint()
      ..strokeWidth = sWidth
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double sweepAngle = 2 * pi * (percent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0,
        sweepAngle, false, animationArc);

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
