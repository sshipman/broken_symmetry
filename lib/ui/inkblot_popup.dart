import 'package:broken_symmetry/data/blobs_provider.dart';
import 'package:broken_symmetry/data/evaluations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/size_provider.dart';
import '../models/blob.dart';
import '../models/evaluation.dart';
import 'inkblot_image.dart';

class InkblotPopup extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _InkblotPopupState();
  }
}

class _InkblotPopupState extends ConsumerState<InkblotPopup> {
  late TextEditingController controller;

  _InkblotPopupState();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit(List<Blob> blobs, String text) {
    Evaluation evaluation = Evaluation(blobs: blobs, answer: text);
    ref.read(evaluationsProvider.notifier).addEvaluation(evaluation);
  }

  @override
  Widget build(BuildContext context) {
    List<Blob> blobs =
        ref.read(blobsProvider).map((Blob b) => b.clone()).toList();
    List<Evaluation> evaluations = ref.read(evaluationsProvider);
    double unitSize = ref.watch(unitSizeProvider);
    Size _size = Size(unitSize * 4, unitSize * 4);

    return AlertDialog(
        title: Text("Evaluation ${evaluations.length + 1}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              InkblotImage(blobs, _size),
              Text("What do you see?")
            ]),
            SizedBox(height: 5),
            TextField(
                autofocus: true,
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "It looks like...",
                ),
                onSubmitted: (String value) {
                  submit(blobs, value);
                  Navigator.of(context).pop(controller.text);
                }),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Submit"),
            onPressed: () {
              submit(blobs, controller.text);
              Navigator.of(context).pop(controller.text);
            },
          )
        ]);
  }
}

Future<String?> showInkblotPopup(
  BuildContext context,
) {
  return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return InkblotPopup();
      },
      barrierDismissible: false);
}
