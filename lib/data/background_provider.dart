// load Image

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

Random random = Random();

List<String> backgrounds = [
  'https://flax.wtf/broken_symmetry/dead_bat.jpg',
  'https://flax.wtf/broken_symmetry/dino_bike.jpg',
  'https://flax.wtf/broken_symmetry/forest.jpg',
  'https://flax.wtf/broken_symmetry/hallway.jpg',
  'https://flax.wtf/broken_symmetry/phantom_lake.jpg',
  'https://flax.wtf/broken_symmetry/spider_bg.jpg',
];
Future<Image> _getImage() async {
  String imgUrl = backgrounds[random.nextInt(backgrounds.length)];
  Uri uri = Uri.parse(imgUrl);
  Response response = await get(uri);
  Uint8List bytes = response.bodyBytes;
  final Completer<Image> completer = Completer();
  decodeImageFromList(bytes, (Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

class BackgroundImageNotifier extends StateNotifier<Image?> {
  BackgroundImageNotifier(Image? state) : super(state);

  void update(Image image) {
    state = image;
  }
}

final backgroundImageNotifier = BackgroundImageNotifier(null);

final currentBackgroundImageProvider =
    StateNotifierProvider<BackgroundImageNotifier, Image?>((ref) {
  return backgroundImageNotifier;
});

void initBackground() {
  _getImage().then((Image img) {
    backgroundImageNotifier.update(img);
  });
}
