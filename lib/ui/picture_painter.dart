import 'dart:ui';

import 'package:flutter/widgets.dart';

class PicturePainter extends CustomPainter {
  Picture picture;

  PicturePainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
