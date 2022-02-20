import 'package:broken_symmetry/data/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int moves = ref.watch(scoreProvider);
    return Center(
        heightFactor: 3,
        child: Text("Moves: $moves", style: TextStyle(fontSize: 36)));
  }
}
