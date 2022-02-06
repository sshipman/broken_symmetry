import 'package:flutter/material.dart';

import '../models/slide_tile_data.dart';
import 'tile.dart';

class SlideTile extends StatelessWidget {
  SlideTileData data;

  SlideTile(this.data);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        child: Tile(data),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        left: data.calculateLeft(),
        top: data.calculateTop());
  }
}
