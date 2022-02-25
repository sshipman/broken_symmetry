import 'dart:math';

import 'package:broken_symmetry/utils/random_source.dart';

double _vinit = 0.005;
double _perturb = 0.0005;
double _vmax = 0.005;

Random _random = RandomSource.instance;

class ControlPoint {
  double x;
  double y;

  double vx;
  double vy;

  ControlPoint(this.x, this.y, this.vx, this.vy);

  factory ControlPoint.random() {
    return ControlPoint(
        _random.nextDouble(),
        _random.nextDouble(),
        (_random.nextDouble() * _vinit) - (_vinit / 2),
        (_random.nextDouble() * _vinit) - (_vinit / 2));
  }

  ControlPoint clone() {
    return ControlPoint(this.x, this.y, this.vx, this.vy);
  }

  Point<double> midPoint(ControlPoint other) {
    return Point<double>((x + other.x) / 2, (y + other.y) / 2);
  }

  void tick() {
    double nx = x += vx;
    if (nx < 0) {
      nx = 0;
      vx *= -1;
    }
    if (nx > 1) {
      nx = 1;
      vx *= -1;
    }
    x = nx;
    double ny = y += vy;
    if (ny < 0) {
      ny = 0;
      vy *= -1;
    }
    if (ny > 1) {
      ny = 1;
      vy *= -1;
    }
    y = ny;

    double nvx = vx + (_random.nextDouble() * _perturb) - (_perturb / 2);
    vx = min(_vmax, max(-_vmax, nvx));
  }
}
