import 'dart:ui';

import 'package:flutter/cupertino.dart';

class PicturePortion extends StatelessWidget {
  Picture picture;
  Rect rect;

  PicturePortion(this.picture, this.rect);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PicturePortionPainter(picture, rect),
      //child: Text("left: ${rect.left}, top:${rect.top}")
    );
  }
}

class PicturePortionPainter extends CustomPainter {
  Picture picture;
  Rect rect;

  PicturePortionPainter(this.picture, this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    PictureRecorder recorder = PictureRecorder();
    Canvas clipped = Canvas(recorder);
    clipped.clipRect(rect);
    clipped.drawPicture(picture);
    Picture cropped = recorder.endRecording();
    canvas.save();
    canvas.translate(-rect.left, -rect.top);
    canvas.drawPicture(cropped);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
