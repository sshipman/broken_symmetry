import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/puzzle_provider.dart';
import 'waiver.dart';

class Splash extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset("images/broken2.svg",
                    height: height / 3,
                    color: Colors.black,
                    semanticsLabel: 'title: Broken symmetry'),
                SvgPicture.asset(
                  "images/symmetry2.svg",
                  color: Colors.grey,
                  height: height / 5,
                ),
                FractionallySizedBox(
                    widthFactor: 0.33,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/game");
                          Future.delayed(Duration(milliseconds: 500)).then((_) {
                            showWaiver(context);
                          }).then((_) {
                            PuzzleNotifier puzzleNotifier =
                                ref.read(puzzleProvider.notifier);
                            puzzleNotifier.shuffle();
                          });
                        },
                        child: Text("Begin")))
              ],
            ),
          ),
        );
      },
    );
  }
}
