import 'dart:math';

import 'package:broken_symmetry/data/size_provider.dart';
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

  void setHasFocus(bool focussed) {
    state.hasFocus = focussed;
    forceUpdate();
  }

  void setFocusLocation(Point<int> focusLocation) {
    print("setting focus location to $focusLocation");
    state.focusLocation = focusLocation;
    forceUpdate();
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
  double unitSize = ref.watch(unitSizeProvider);
  return PuzzleNotifier(dim: 4, cellSize: unitSize);
});
