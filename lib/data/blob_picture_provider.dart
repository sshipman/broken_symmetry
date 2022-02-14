import 'dart:ui';

import 'package:broken_symmetry/data/size_provider.dart';
import 'package:broken_symmetry/models/blob.dart';
import 'package:broken_symmetry/utils/blobs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'blobs_provider.dart';

final StateProvider<Picture> pictureProvider = StateProvider<Picture>((ref) {
  double unitSize = ref.watch(unitSizeProvider);
  Size _size = Size(unitSize * 4, unitSize * 4);
  List<Blob> blobs = ref.watch(blobsProvider);
  return createBlobsPicture(blobs, _size);
});
