import 'dart:math';

class SlideTileData {
  int solutionRow;
  int solutionCol;
  int row;
  int col;
  int index;
  double size;

  SlideTileData(
      {required this.row,
      required this.col,
      required this.index,
      required this.size})
      : solutionRow = row,
        solutionCol = col;

  double calculateLeft() {
    return col * size;
  }

  double calculateTop() {
    return row * size;
  }

  void applyDelta(Point<int> delta) {
    row += delta.y;
    col += delta.x;
  }

  bool get isCorrect {
    return row == solutionRow && col == solutionCol;
  }
}
