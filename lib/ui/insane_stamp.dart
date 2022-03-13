import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InsaneStamp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InsaneStampState();
  }
}

class _InsaneStampState extends State<InsaneStamp> {
  double scale = 6;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        scale = 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        child: SvgPicture.asset("images/insane.svg", color: Colors.red));
  }
}
