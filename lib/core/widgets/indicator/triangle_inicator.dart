import 'package:flutter/material.dart';

class TriangleIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleIndicator({required Color color, required double radius, bool isReverse = false})
      : _painter = _TrianglePainter(color, radius, isReverse);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _TrianglePainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final bool isReverse;

  _TrianglePainter(Color color, this.radius, this.isReverse)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final width = configuration.size!.width;
    final height = configuration.size!.height;
    final center = offset + Offset(width / 2, height);
    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx - radius, center.dy + (isReverse ? -radius : radius))
      ..lineTo(center.dx + radius, center.dy + (isReverse ? -radius : radius))
      ..close();

    canvas.drawPath(path, _paint);
  }
}