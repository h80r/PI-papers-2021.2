import 'dart:math';

class Mask {
  Mask.simple(int size) {
    mask = List.generate(size, (y) => List.generate(size, (x) => 1));
  }

  Mask.gaussian(int size) {
    final center = Point(size ~/ 2, size ~/ 2);

    mask = List.generate(
      size,
      (y) => List.generate(
        size,
        (x) {
          final currentPoint = Point(x, y);
          final distance = currentPoint.distanceTo(center);
          return pow(2, (size / 2).ceil() - distance.ceil()).toInt();
        },
      ),
    );
  }

  late final List<List<int>> mask;

  @override
  String toString() {
    return mask.fold(
      '',
      (previousValue, element) => previousValue + '\n' + element.toString(),
    );
  }
}
