import 'package:broken_symmetry/data/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';

class ScoreDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int moves = ref.watch(scoreProvider);
    int movesLeft = movesLimit - moves;
    TextSpan warnContent = movesLeft < 25
        ? TextSpan(
            text: "$movesLeft moves left!",
            style: TextStyle(fontSize: 32, color: Colors.red))
        : TextSpan(text: "");
    return Center(
        heightFactor: 3,
        child: RichText(
            text: TextSpan(
                text: "Moves: $moves ",
                style: TextStyle(fontSize: 32, color: Colors.black),
                children: [warnContent])));
  }
}
