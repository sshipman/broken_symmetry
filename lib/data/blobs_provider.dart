import 'package:broken_symmetry/models/blob.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlobsNotifier extends StateNotifier<List<Blob>> {
  BlobsNotifier(List<Blob> state) : super(state);

  void step() {
    state.forEach((Blob blob) {
      blob.tick();
    });
    state = [...state];
  }
}

final blobsProvider = StateNotifierProvider<BlobsNotifier, List<Blob>>((ref) {
  return BlobsNotifier([Blob(), Blob()]);
});
