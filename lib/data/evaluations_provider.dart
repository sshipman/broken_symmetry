import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/evaluation.dart';

class EvaluationsNotifier extends StateNotifier<List<Evaluation>> {
  EvaluationsNotifier(List<Evaluation> evaluations) : super(evaluations);

  void reset() {
    state = [];
  }

  void addEvaluation(Evaluation evaluation) {
    state = [...state, evaluation];
  }
}

final evaluationsProvider =
    StateNotifierProvider<EvaluationsNotifier, List<Evaluation>>((ref) {
  return EvaluationsNotifier([]);
});
