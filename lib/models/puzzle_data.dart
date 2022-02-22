import 'dart:math';

import 'package:broken_symmetry/models/slide_tile_data.dart';

class PuzzleData {
  int dim;
  List<SlideTileData> slideTiles;
  Point<int> spaceLocation;
  Point<int> focusLocation;
  bool hasFocus;

  PuzzleData(
      {required this.dim,
      required this.slideTiles,
      required this.spaceLocation,
      this.hasFocus = false,
      this.focusLocation = const Point<int>(0, 0)});

  factory PuzzleData.blank() {
    return PuzzleData(dim: 0, slideTiles: [], spaceLocation: Point(0, 0));
  }

  factory PuzzleData.copy(PuzzleData orig) {
    return PuzzleData(
        dim: orig.dim,
        slideTiles: orig.slideTiles,
        spaceLocation: orig.spaceLocation,
        hasFocus: orig.hasFocus,
        focusLocation: orig.focusLocation);
  }

  factory PuzzleData.dimensioned({required int dim}) {
    List<SlideTileData> slideTiles =
        List.generate((dim * dim) - 1, (int index) {
      int row = (index / dim).floor();
      int col = index % dim;
      return SlideTileData(row: row, col: col, index: index);
    });
    Point<int> spaceLocation = Point(dim - 1, dim - 1);
    return PuzzleData(
        dim: dim, slideTiles: slideTiles, spaceLocation: spaceLocation);
  }

  int _getInversionCount() {
    int inversionCount = 0;
    for (int i = 0; i < ((dim * dim) - 2); i++) {
      for (int j = i; j < ((dim * dim) - 1); j++) {
        if (slideTiles[i].index > slideTiles[j].index) {
          inversionCount++;
        }
      }
    }
    return inversionCount;
  }

  bool _isSolvable() {
    int inversionCount = _getInversionCount();
    if (dim.isOdd) {
      return inversionCount.isEven;
    } else {
      //assumes space is at the bottom right
      return inversionCount.isEven;
    }
  }

  void shuffle() {
    // shuffle slideTiles, then assign them row/col based on their new positions.
    slideTiles.shuffle();
    int c = 0;
    while (!_isSolvable() && c < 100) {
      print("shuffle attempt $c, and not solvable");
      slideTiles.shuffle();
      c++;
    }
    spaceLocation = Point(dim - 1, dim - 1);
    int index = 0;
    for (var slideTile in slideTiles) {
      slideTile.row = (index / dim).floor();
      slideTile.col = (index % dim);
      index++;
    }
  }

  bool get isCorrect {
    return slideTiles.every((SlideTileData element) => element.isCorrect);
  }
}
