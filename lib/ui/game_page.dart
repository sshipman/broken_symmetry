import 'dart:async';

import 'package:broken_symmetry/data/background_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blobs_provider.dart';
import '../data/puzzle_provider.dart';
import '../data/score_provider.dart';
import 'score_display.dart';
import 'size_watcher_container.dart';
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
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            }),
      ]),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ScoreDisplay(),
        Expanded(child: SizeWatcherContainer(child: SlidePuzzleGrid())),
        Center(
          heightFactor: 3,
          child: ElevatedButton(
              onPressed: () {
                PuzzleNotifier puzzleNotifier =
                    ref.read(puzzleProvider.notifier);
                puzzleNotifier.shuffle();
                ScoreNotifier scoreNotifier = ref.read(scoreProvider.notifier);
                scoreNotifier.reset();
                initBackground();
              },
              child: Text("Restart")),
        )
      ]),
    );
  }
}
