import 'dart:math';

class SlideTileData {
  int solutionRow;
  int solutionCol;
  int row;
  int col;
  int index;

  SlideTileData({
    required this.row,
    required this.col,
    required this.index,
  })  : solutionRow = row,
        solutionCol = col;

  double calculateLeft(double size) {
    return col * size;
  }

  double calculateTop(double size) {
    return row * size;
  }

  void applyDelta(Point<int> delta) {
    row += delta.y;
    col += delta.x;
  }

  bool atPoint(Point<int> p) {
    return row == p.y && col == p.x;
  }

  bool get isCorrect {
    return row == solutionRow && col == solutionCol;
  }
}
