import 'package:broken_symmetry/data/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int moves = ref.watch(scoreProvider);
    return Text("Moves: $moves");
  }
}
