import 'dart:ui';

import 'package:broken_symmetry/models/blob.dart';
import 'package:broken_symmetry/utils/blobs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'blobs_provider.dart';

final _size = Size(800, 800); //todo: make more dynamic.

final StateProvider<Picture> pictureProvider = StateProvider<Picture>((ref) {
  List<Blob> blobs = ref.watch(blobsProvider);
  return createBlobsPicture(blobs, _size);
});
