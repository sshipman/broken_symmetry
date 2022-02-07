import 'dart:math';

import 'package:broken_symmetry/models/slide_tile_data.dart';

class PuzzleData {
  int dim;
  double cellSize;
  List<SlideTileData> slideTiles;
  Point<int> spaceLocation;
  Point<int> focusLocation;
  bool hasFocus;

  PuzzleData(
      {required this.dim,
      required this.cellSize,
      required this.slideTiles,
      required this.spaceLocation,
      this.hasFocus = false,
      this.focusLocation = const Point<int>(0, 0)});

  factory PuzzleData.blank() {
    return PuzzleData(
        dim: 0, cellSize: 1, slideTiles: [], spaceLocation: Point(0, 0));
  }

  factory PuzzleData.copy(PuzzleData orig) {
    return PuzzleData(
        dim: orig.dim,
        cellSize: orig.cellSize,
        slideTiles: orig.slideTiles,
        spaceLocation: orig.spaceLocation,
        hasFocus: orig.hasFocus,
        focusLocation: orig.focusLocation);
  }

  factory PuzzleData.dimensioned({required int dim, required double cellSize}) {
    List<SlideTileData> slideTiles =
        List.generate((dim * dim) - 1, (int index) {
      int row = (index / dim).floor();
      int col = index % dim;
      return SlideTileData(row: row, col: col, index: index, size: cellSize);
    });
    Point<int> spaceLocation = Point(dim - 1, dim - 1);
    return PuzzleData(
        dim: dim,
        cellSize: cellSize,
        slideTiles: slideTiles,
        spaceLocation: spaceLocation);
  }

  void shuffle() {
    // shuffle slideTiles, then assign them row/col based on their new positions.
    slideTiles.shuffle();
    int index = 0;
    for (var slideTile in slideTiles) {
      slideTile.row = (index / dim).floor();
      slideTile.col = (index % dim);
      index++;
    }
  }
}
