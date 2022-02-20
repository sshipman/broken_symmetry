import 'dart:ui';

import 'package:broken_symmetry/models/blob.dart';
import 'package:flutter/material.dart' hide Image;

///assorted utils for blobs

Picture createBlobsPicture(List<Blob> blobs, Image? background, Size size) {
  PictureRecorder pictureRecorder = PictureRecorder();
  Canvas draft = Canvas(pictureRecorder);
  blobs.forEach((Blob blob) {
    blob.drawIntoCanvas(draft, size);
  });
  Picture half = pictureRecorder.endRecording();
  PictureRecorder fullPictureRecorder = PictureRecorder();
  Canvas full = Canvas(fullPictureRecorder);
  if (background != null) {
    paintImage(
        canvas: full,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: background,
        fit: BoxFit.scaleDown,
        repeat: ImageRepeat.noRepeat,
        scale: 1.0,
        alignment: Alignment.center,
        flipHorizontally: false,
        filterQuality: FilterQuality.high);
  }
  full.drawPicture(half);
  full.scale(-1, 1);
  full.translate(-size.width, 0);
  full.drawPicture(half);
  return fullPictureRecorder.endRecording();
}
