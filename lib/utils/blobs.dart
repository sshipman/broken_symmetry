import 'dart:ui';

import 'package:broken_symmetry/models/blob.dart';
import 'package:flutter/material.dart';

///assorted utils for blobs

Picture createBlobsPicture(List<Blob> blobs, Size size) {
  PictureRecorder pictureRecorder = PictureRecorder();
  Canvas draft = Canvas(pictureRecorder);
  blobs.forEach((Blob blob) {
    blob.drawIntoCanvas(draft, size);
  });
  Picture half = pictureRecorder.endRecording();
  PictureRecorder fullPictureRecorder = PictureRecorder();
  Canvas full = Canvas(fullPictureRecorder);
  Paint gradientBG = Paint()
    ..shader = RadialGradient(colors: [Colors.white, Colors.purple])
        .createShader(Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.shortestSide / 2));
  full.drawPaint(gradientBG);
  full.drawPicture(half);
  full.scale(-1, 1);
  full.translate(-size.width, 0);
  full.drawPicture(half);
  return fullPictureRecorder.endRecording();
}
