import 'dart:ui';

import 'package:broken_symmetry/data/blob_picture_provider.dart';
import 'package:broken_symmetry/data/size_provider.dart';
import 'package:broken_symmetry/ui/picture_portion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/slide_tile_data.dart';

class Tile extends ConsumerWidget {
  SlideTileData data;

  Tile(this.data);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double unitSize = ref.watch(unitSizeProvider);
    Picture picture = ref.watch(pictureProvider);
    return Container(
      alignment: Alignment.topLeft,
      width: data.size,
      height: data.size,
      child: Stack(
        children: [
          PicturePortion(
              picture,
              Rect.fromLTWH(data.solutionCol * unitSize,
                  data.solutionRow * unitSize, unitSize, unitSize)),
          Text("${data.index}",
              style: TextStyle(fontSize: 16, color: Colors.white))
        ],
      ),
      // oddly, without this boxdecoration, the tap gesture is not detected.
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
