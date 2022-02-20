import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset("images/broken2.svg",
                  height: height / 3,
                  color: Colors.black,
                  semanticsLabel: 'title: Broken symmetry'),
              SvgPicture.asset(
                "images/symmetry2.svg",
                color: Colors.grey,
                height: height / 5,
              ),
              FractionallySizedBox(
                  widthFactor: 0.25,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/game");
                      },
                      child: Text("Begin")))
            ],
          ),
        );
      },
    );
  }
}
