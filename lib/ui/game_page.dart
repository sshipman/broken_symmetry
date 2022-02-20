import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blobs_provider.dart';
import '../data/puzzle_provider.dart';
import '../data/score_provider.dart';
import 'score_display.dart';
import 'slide_puzzle_grid.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<GamePage> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends ConsumerState<GamePage> {
  late Timer timer;

  @override
  initState() {
    BlobsNotifier blobsNotifier = ref.read(blobsProvider.notifier);
    timer = Timer.periodic(Duration(milliseconds: 20), (Timer timer) {
      blobsNotifier.step();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ScoreDisplay(),
        Expanded(child: SlidePuzzleGrid()),
        Center(
          heightFactor: 3,
          child: ElevatedButton(
              onPressed: () {
                PuzzleNotifier puzzleNotifier =
                    ref.read(puzzleProvider.notifier);
                ScoreNotifier scoreNotifier = ref.read(scoreProvider.notifier);
                puzzleNotifier.shuffle();
                scoreNotifier.reset();
              },
              child: Text("Shuffle")),
        )
      ]),
    );
  }
}
