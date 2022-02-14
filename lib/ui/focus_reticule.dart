import 'package:broken_symmetry/data/puzzle_provider.dart';
import 'package:broken_symmetry/data/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/puzzle_data.dart';

class FocusReticule extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double unitSize = ref.watch(unitSizeProvider);
    PuzzleData puzzleData = ref.watch(puzzleProvider);
    return puzzleData.hasFocus
        ? Positioned(
            left: puzzleData.focusLocation.x * unitSize,
            top: puzzleData.focusLocation.y * unitSize,
            child: Container(
              width: unitSize,
              height: unitSize,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 5)),
            ),
          )
        : Container();
  }
}
