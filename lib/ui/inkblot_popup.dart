import 'package:broken_symmetry/data/blobs_provider.dart';
import 'package:broken_symmetry/data/evaluations_provider.dart';
import 'package:broken_symmetry/utils/random_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/blob.dart';
import '../models/evaluation.dart';
import 'inkblot_image.dart';

List<String> _responses = [
  "Hmm, okay, I can see that",
  "That's... concerning",
  'No, the correct answer is: "Mommy wrestling Daddy"',
  "Wow.  OK.",
  "Correct.",
  "What? How?",
  "I don't think you're taking this seriously",
  "That's a very... creative interpretation",
  "Nope.  Wrong.",
  "I thought it was a butterfly",
  "I'm beginning to understand how you think, and it frightens me.",
  "That sort of language really isn't appropriate",
  "Please, answer honestly",
  "Right.  And what's your current dosage again?",
  "Yeah, that one's obvious",
  "Let’s pause for a second to think about what you’ve just said",
  "Now you’re making me hungry",
  "There are no wrong answers... except that one"
];

class InkblotPopup extends ConsumerStatefulWidget {
  const InkblotPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _InkblotPopupState();
  }
}

class _InkblotPopupState extends ConsumerState<InkblotPopup> {
  late TextEditingController controller;
  String response = "";
  bool alreadySubmit = false;
  late List<Blob> blobs;
  Duration postResponseDuration = const Duration(seconds: 3);

  _InkblotPopupState();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "");
    blobs = ref.read(blobsProvider).map((Blob b) => b.clone()).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String chooseResponse() {
    return _responses[RandomSource.instance.nextInt(_responses.length)];
  }

  void submit(List<Blob> blobs, String text) {
    Evaluation evaluation = Evaluation(blobs: blobs, answer: text);
    ref.read(evaluationsProvider.notifier).addEvaluation(evaluation);
    setState(() {
      response = chooseResponse();
      alreadySubmit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Evaluation> evaluations = ref.read(evaluationsProvider);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double size = constraints.maxWidth / 3;
      return AlertDialog(
          title: Text("Evaluation ${evaluations.length + 1}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AnimatedContainer(
                  duration: postResponseDuration,
                  width: alreadySubmit ? 0 : size * 2,
                  height: 5,
                  color: Colors.green,
                ),
              ),
              Row(children: [
                InkblotImage(blobs, Size(size, size)),
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      const Text("What do you see?"),
                      AnimatedOpacity(
                          opacity: response.isEmpty ? 0 : 1,
                          duration: const Duration(milliseconds: 500),
                          child: Text(response,
                              style: const TextStyle(color: Colors.green)))
                    ],
                  ),
                )
              ]),
              const SizedBox(height: 5),
              TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "It looks like...",
                  ),
                  onSubmitted: (String value) {
                    if (alreadySubmit) {
                      return;
                    }
                    submit(blobs, value);
                    Future.delayed(postResponseDuration, () {
                      Navigator.of(context).pop(controller.text);
                    });
                  }),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: () async {
                if (alreadySubmit) {
                  return;
                }
                submit(blobs, controller.text);
                Future.delayed(postResponseDuration, () {
                  Navigator.of(context).pop(controller.text);
                });
              },
            )
          ]);
    });
  }
}

Future<String?> showInkblotPopup(
  BuildContext context,
) {
  return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return const InkblotPopup();
      },
      barrierDismissible: false);
}
