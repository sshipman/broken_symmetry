import 'dart:math';

import 'package:broken_symmetry/models/puzzle_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleNotifier extends StateNotifier<PuzzleData> {
  int dim;

  PuzzleNotifier({required this.dim}) : super(PuzzleData.dimensioned(dim: dim));

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
    forceUpdate();
  }
}

final puzzleProvider = StateNotifierProvider<PuzzleNotifier, PuzzleData>((ref) {
  return PuzzleNotifier(dim: 4);
});
