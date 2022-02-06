import 'dart:math';

import 'package:broken_symmetry/models/puzzle_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleNotifier extends StateNotifier<PuzzleData> {
  int dim;
  double cellSize;

  PuzzleNotifier({required this.dim, required this.cellSize})
      : super(PuzzleData.dimensioned(dim: dim, cellSize: cellSize));

  void forceUpdate() {
    state = PuzzleData.copy(state);
  }

  void setSpaceLocation(Point<int> spaceLocation) {
    state.spaceLocation = spaceLocation;
    forceUpdate();
  }

  void shuffle() {
    state.shuffle();
    state.spaceLocation = Point(dim - 1, dim - 1);
    forceUpdate();
  }
}

final puzzleProvider = StateNotifierProvider<PuzzleNotifier, PuzzleData>((ref) {
  return PuzzleNotifier(dim: 4, cellSize: 200);
});
