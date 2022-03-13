import 'package:broken_symmetry/data/evaluations_provider.dart';
import 'package:broken_symmetry/data/game_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/background_provider.dart';
import '../data/puzzle_provider.dart';
import '../data/score_provider.dart';
import 'score_display.dart';
import 'size_watcher_container.dart';
import 'slide_puzzle_grid.dart';

class GameContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ScoreDisplay(),
      Expanded(child: SizeWatcherContainer(child: SlidePuzzleGrid())),
      Center(
        heightFactor: 3,
        child: ElevatedButton(
            onPressed: () {
              PuzzleNotifier puzzleNotifier = ref.read(puzzleProvider.notifier);
              puzzleNotifier.shuffle();
              ScoreNotifier scoreNotifier = ref.read(scoreProvider.notifier);
              scoreNotifier.reset();
              GameStatusNotifier gameStatusNotifier =
                  ref.read(gameStatusProvider.notifier);
              gameStatusNotifier.reset();
              EvaluationsNotifier evaluationsNotifier =
                  ref.read(evaluationsProvider.notifier);
              evaluationsNotifier.reset();
              initBackground();
            },
            child: Text("Restart")),
      )
    ]);
  }
}
