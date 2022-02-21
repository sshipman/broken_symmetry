import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

final Soundpool pool = Soundpool.fromOptions(options: SoundpoolOptions());

bool _loaded = false;
late int tileMoveId;

initSound() async {
  ByteData byteData = await rootBundle.load("sounds/151224__owlstorm__shush.wav");
  tileMoveId = await pool.load(byteData);
  _loaded = true;
}

Future<int> playTileMove() {
  if (_loaded) {
    return pool.play(tileMoveId);
  }
  return Future.value(-1);
}
