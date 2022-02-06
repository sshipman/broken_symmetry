import 'dart:math';

class RandomSource {
  static Random? _instance;

  static Random get instance {
    if (_instance == null) {
      _instance = Random(DateTime.now().millisecondsSinceEpoch);
    }
    return _instance!;
  }
}
