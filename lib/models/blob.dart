// a Blob is a collection of ControlPoints
// it has a convenience method to draw into a canvas.
// and a tick method to advance the ControlPoints

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'control_point.dart';

Paint _paint = Paint()
  ..color = const Color(0x88000000)
  ..style = PaintingStyle.fill;

class Blob {
  late List<ControlPoint> controlPoints;

  Blob(this.controlPoints);

  Blob.generate({int numPoints = 4}) {
    controlPoints = List<ControlPoint>.generate(
        numPoints, (index) => ControlPoint.random());
  }

  Blob clone() {
    return Blob(this.controlPoints.map((ControlPoint cp) {
      return cp.clone();
    }).toList());
  }

  void tick() {
    controlPoints.forEach((ControlPoint controlPoint) {
      controlPoint.tick();
    });
  }

  void drawIntoCanvas(Canvas canvas, Size size) {
    Path path = new Path();
    //move to midpoint of last cp and first cp
    Point<double> prevMidpoint =
        controlPoints.first.midPoint(controlPoints.last);
    path.moveTo(size.width * prevMidpoint.x, size.height * prevMidpoint.y);

    for (int cpIdx = 0; cpIdx < controlPoints.length; cpIdx++) {
      ControlPoint point = controlPoints[cpIdx];
      ControlPoint nextPoint =
          controlPoints[(cpIdx + 1) % controlPoints.length];
      Point<double> nextMidpoint = point.midPoint(nextPoint);
      path.quadraticBezierTo(size.width * point.x, size.height * point.y,
          size.width * nextMidpoint.x, size.height * nextMidpoint.y);
    }
    canvas.drawPath(path, _paint);
  }
}
