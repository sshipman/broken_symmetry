import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/preferences.dart';

SharedPreferences? _prefs;

void initPrefs() async {
  _prefs = await SharedPreferences.getInstance();
  if (_prefs != null) {
    _prefsNotifier.setPlaySounds(_prefs!.getBool("playSounds") ?? true);
  }
}

PrefsNotifier _prefsNotifier = PrefsNotifier(Preferences(playSounds: true));

class PrefsNotifier extends StateNotifier<Preferences> {
  PrefsNotifier(Preferences state) : super(state);

  void setPlaySounds(bool playSounds) {
    _prefs?.setBool("playSounds", playSounds);
    state = Preferences(playSounds: playSounds);
  }
}

final prefsProvider = StateNotifierProvider<PrefsNotifier, Preferences>((ref) {
  return _prefsNotifier;
});
