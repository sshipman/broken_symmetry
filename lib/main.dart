import 'dart:async';

import 'package:broken_symmetry/data/puzzle_provider.dart';
import 'package:broken_symmetry/ui/score_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/blobs_provider.dart';
import 'data/score_provider.dart';
import 'ui/slide_puzzle_grid.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const BrokenSymmetry(title: 'Broken Symmetry'),
    );
  }
}

class BrokenSymmetry extends ConsumerStatefulWidget {
  const BrokenSymmetry({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<BrokenSymmetry> createState() {
    return _BrokenSymmetryState();
  }
}

class _BrokenSymmetryState extends ConsumerState<BrokenSymmetry> {
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
        ElevatedButton(
            onPressed: () {
              PuzzleNotifier puzzleNotifier = ref.read(puzzleProvider.notifier);
              ScoreNotifier scoreNotifier = ref.read(scoreProvider.notifier);
              puzzleNotifier.shuffle();
              scoreNotifier.reset();
            },
            child: Text("Shuffle"))
      ]),
    );
  }
}
