import 'dart:async';

import 'package:broken_symmetry/ui/inkblot_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blobs_provider.dart';
import '../data/score_provider.dart';
import 'evaluations_list_view.dart';
import 'game_content.dart';
import 'tabbed_game_screen.dart';

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
    ref.listen<int>(scoreProvider, (previous, next) {
      if (next % 23 == 0 && next > 0) {
        showInkblotPopup(context);
      }
    });
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.width > 1000
        ? Scaffold(
            appBar: AppBar(title: Text(widget.title), actions: [
              IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Settings',
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  }),
            ]),
            body: Row(children: [
              Expanded(child: GameContent(), flex: 2),
              Expanded(child: EvaluationsListView())
            ]))
        : TabbedGameScreen();
  }
}
