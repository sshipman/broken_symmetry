import 'package:broken_symmetry/data/evaluations_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/evaluation.dart';
import 'inkblot_image.dart';

class EvaluationsListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Evaluation> evaluations = ref.watch(evaluationsProvider);
    return ListView.builder(
        itemCount: evaluations.length,
        itemBuilder: (BuildContext context, int index) {
          Evaluation evaluation = evaluations[index];
          return Row(children: [
            InkblotImage(evaluation.blobs, Size(100, 100)),
            Text(evaluation.answer)
          ]);
        });
  }
}
