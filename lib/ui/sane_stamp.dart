import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaneStamp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SaneStampState();
  }
}

class _SaneStampState extends State<SaneStamp> {
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
        child: SvgPicture.asset("images/sane.svg", color: Colors.red));
  }
}
