import 'package:flutter/material.dart';

Future<void> showWaiver(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
              title: const Text("Disclaimer"),
              content: Waiver(),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text("Close"))
              ]));
}

class Waiver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Thank you for participating in our research study.\n"
        "Please relax and let your mind wander while you solve the puzzle.\n"
        "We cannot take responsibility for any psychosis, discovered or induced,\n"
        "by this exercise.");
  }
}
