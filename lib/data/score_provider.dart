import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreNotifier extends StateNotifier<int> {
  ScoreNotifier() : super(0);

  void reset() {
    state = 0;
  }

  void increment() {
    state = state + 1;
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, int>((ref) {
  return ScoreNotifier();
});
