import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/size_provider.dart';
import '../models/slide_tile_data.dart';
import 'tile.dart';

class SlideTile extends ConsumerWidget {
  SlideTileData data;

  SlideTile(this.data);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double unitSize = ref.watch(unitSizeProvider);

    return AnimatedPositioned(
        child: Tile(data),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        left: data.calculateLeft(unitSize),
        top: data.calculateTop(unitSize));
  }
}
