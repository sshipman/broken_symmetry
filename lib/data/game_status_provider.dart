import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_status.dart';

class GameStatusNotifier extends StateNotifier<GameStatus> {
  GameStatusNotifier() : super(GameStatus.ACTIVE);

  void reset() {
    state = GameStatus.ACTIVE;
  }

  void finish() {
    state = GameStatus.FINISHED;
  }
}

final gameStatusProvider =
    StateNotifierProvider<GameStatusNotifier, GameStatus>((ref) {
  return GameStatusNotifier();
});
