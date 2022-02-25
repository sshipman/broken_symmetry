import 'dart:ui';

import 'package:broken_symmetry/utils/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/blob.dart';
import 'picture_painter.dart';

class InkblotImage extends StatelessWidget {
  List<Blob> blobs;
  Size size;

  InkblotImage(this.blobs, this.size);

  @override
  Widget build(BuildContext context) {
    Picture inkBlot = createBlobsPicture(blobs, null, size);
    return SizedBox(
        height: size.height,
        width: size.width,
        child: CustomPaint(
          painter: PicturePainter(inkBlot),
          size: size,
        ));
  }
}
