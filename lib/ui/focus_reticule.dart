import 'package:broken_symmetry/data/puzzle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/puzzle_data.dart';

class FocusReticule extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PuzzleData puzzleData = ref.watch(puzzleProvider);
    return puzzleData.hasFocus
        ? Positioned(
            left: puzzleData.focusLocation.x * 200,
            top: puzzleData.focusLocation.y * 200,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 5)),
            ),
          )
        : Container();
  }
}
