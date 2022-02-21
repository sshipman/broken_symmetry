import 'package:broken_symmetry/data/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/preferences.dart';

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Preferences prefs = ref.watch(prefsProvider);
    PrefsNotifier prefsNotifier = ref.watch(prefsProvider.notifier);
    return Scaffold(
        appBar: AppBar(title: Text("Broken Symmetry")),
        body: Row(children: [
          Text("Play Sounds"),
          Switch(
              onChanged: (bool value) {
                prefsNotifier.setPlaySounds(value);
              },
              value: prefs.playSounds)
        ]));
  }
}
