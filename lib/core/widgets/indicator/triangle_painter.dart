
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Paint _paint;

  TrianglePainter(Color color) : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
