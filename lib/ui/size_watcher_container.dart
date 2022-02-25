import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/size_provider.dart';

class SizeWatcherContainer extends ConsumerWidget {
  Widget child;

  SizeWatcherContainer({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double unitSize = constraints.biggest.shortestSide / 4;
      double boxSize = unitSize * 4;
      SizeNotifier sizeNotifier = ref.read(unitSizeProvider.notifier);
      double existingUnitSize = ref.read(unitSizeProvider);
      if (unitSize != existingUnitSize) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          sizeNotifier.setUnitSize(unitSize);
        });
      }
      return SizedBox(width: boxSize, height: boxSize, child: child);
    });
  }
}
