import 'dart:math';

import 'package:broken_symmetry/data/puzzle_provider.dart';
import 'package:broken_symmetry/data/score_provider.dart';
import 'package:broken_symmetry/models/puzzle_data.dart';
import 'package:broken_symmetry/ui/focus_reticule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/size_provider.dart';
import '../models/slide_tile_data.dart';
import 'slide_tile.dart';

class SlidePuzzleGrid extends ConsumerWidget {
  Point<int> _calculateCell(Offset offset, double cellSize) {
    int cx = (offset.dx / cellSize).floor();
    int cy = (offset.dy / cellSize).floor();
    return Point(cx, cy);
  }

  void _applyTap(Point<int> tapCell, PuzzleData puzzleData,
      PuzzleNotifier puzzleNotifier, ScoreNotifier scoreNotifier) {
    if ((tapCell.x != puzzleData.spaceLocation.x) &&
        (tapCell.y != puzzleData.spaceLocation.y)) {
      //if neither col nor row matches, ignore it.
      return;
    }
    List<SlideTileData> tilesToMove = _getMoveCells(tapCell, puzzleData);
    Point<int> delta = _getDelta(tapCell, puzzleData.spaceLocation);
    tilesToMove.forEach((SlideTileData element) {
      element.applyDelta(delta);
    });
    puzzleNotifier.setSpaceLocation(tapCell);
    scoreNotifier.increment();
  }

  List<SlideTileData> _getMoveCells(Point<int> tapCell, PuzzleData puzzleData) {
    Point<int> spaceLocation = puzzleData.spaceLocation;
    // get all SlideTileData with coords between tapCell and spaceLocation
    if (tapCell.x == spaceLocation.x) {
      int ylow = min(tapCell.y, spaceLocation.y);
      int yhigh = max(tapCell.y, spaceLocation.y);
      return puzzleData.slideTiles.where((SlideTileData element) {
        return element.col == tapCell.x &&
            element.row >= ylow &&
            element.row <= yhigh;
      }).toList();
    } else if (tapCell.y == spaceLocation.y) {
      int xlow = min(tapCell.x, spaceLocation.x);
      int xhigh = max(tapCell.x, spaceLocation.x);
      return puzzleData.slideTiles.where((SlideTileData element) {
        return element.row == tapCell.y &&
            element.col >= xlow &&
            element.col <= xhigh;
      }).toList();
    }
    return [];
  }

  Point<int> _getDelta(Point<int> tapCell, Point<int> spaceLocation) {
    // return delta to apply to each move cell indicating which direction to move.
    // will be one of {-1, 0}, {1, 0}, {0, -1}, {0, 1}
    if (tapCell.x == spaceLocation.x) {
      if (tapCell.y > spaceLocation.y) {
        return Point(0, -1);
      } else {
        return Point(0, 1);
      }
    } else {
      if (tapCell.x > spaceLocation.x) {
        return Point(-1, 0);
      } else {
        return Point(1, 0);
      }
    }
  }

  void _checkSolution(PuzzleData puzzleData) {
    if (puzzleData.slideTiles
        .every((SlideTileData element) => element.isCorrect)) {
      print("yay!");
    } else {
      print("nope.");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PuzzleData puzzleData = ref.watch(puzzleProvider);
    PuzzleNotifier puzzleNotifier = ref.watch(puzzleProvider.notifier);
    ScoreNotifier scoreNotifier = ref.read(scoreProvider.notifier);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double unitSize = constraints.biggest.shortestSide / 4;
        double boxSize = unitSize * 4;
        SizeNotifier sizeNotifier = ref.read(unitSizeProvider.notifier);
        double existingUnitSize = ref.read(unitSizeProvider);
        if (unitSize != existingUnitSize) {
          Future.delayed(Duration.zero, () {
            sizeNotifier.setUnitSize(unitSize);
          });
        }
        List<Widget> children = [
          ...puzzleData.slideTiles.map(SlideTile.new).toList(),
          FocusReticule()
        ];

        return Focus(
            descendantsAreFocusable: false,
            onFocusChange: (bool focussed) {
              puzzleNotifier.setHasFocus(focussed);
            },
            onKeyEvent: (FocusNode node, KeyEvent event) {
              if (event is KeyUpEvent) {
                Point<int> fl = puzzleData.focusLocation;
                if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                  if (fl.x > 0) {
                    puzzleNotifier.setFocusLocation(Point<int>(fl.x - 1, fl.y));
                  }
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                  if (fl.x < 3) {
                    puzzleNotifier.setFocusLocation(Point<int>(fl.x + 1, fl.y));
                  }
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                  if (fl.y > 0) {
                    puzzleNotifier.setFocusLocation(Point<int>(fl.x, fl.y - 1));
                  }
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                  if (fl.y < 3) {
                    puzzleNotifier.setFocusLocation(Point<int>(fl.x, fl.y + 1));
                  }
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.space ||
                    event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter) {
                  _applyTap(puzzleData.focusLocation, puzzleData,
                      puzzleNotifier, scoreNotifier);
                }
              }
              return KeyEventResult.ignored;
            },
            child: Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: boxSize,
                height: boxSize,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      Point<int> tapCell = _calculateCell(
                          details.localPosition, puzzleData.cellSize);
                      print('${tapCell}');
                      _applyTap(
                          tapCell, puzzleData, puzzleNotifier, scoreNotifier);
                    },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: children,
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
