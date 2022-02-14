import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizeNotifier extends StateNotifier<double> {
  SizeNotifier(double unitSize) : super(unitSize);

  void setUnitSize(double size) {
    state = size;
  }
}

final unitSizeProvider = StateNotifierProvider<SizeNotifier, double>((ref) {
  return SizeNotifier(200);
});
