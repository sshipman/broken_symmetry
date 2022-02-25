import 'package:broken_symmetry/ui/evaluations_list_view.dart';
import 'package:flutter/material.dart';

import 'game_content.dart';

class TabbedGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Broken Symmetry"),
              actions: [
                IconButton(
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    }),
              ],
              bottom: const TabBar(
                  tabs: [Tab(text: "Game"), Tab(text: "Evaluations")]),
            ),
            body:
                TabBarView(children: [GameContent(), EvaluationsListView()])));
  }
}
