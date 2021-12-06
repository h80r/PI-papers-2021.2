import 'dart:math';

class Mask {
  Mask.simple(int size) {
    _mask = List.generate(size, (y) => List.generate(size, (x) => 1));
  }

  Mask.gaussian(int size) {
    final center = Point(size ~/ 2, size ~/ 2);

    _mask = List.generate(
      size,
      (y) => List.generate(
        size,
        (x) {
          final currentPoint = Point(x, y);
          final distance = currentPoint.distanceTo(center);
          return pow(5, (size / 2).ceil() - distance.ceil()).toInt();
        },
      ),
    );
  }

  late final List<List<int>> _mask;
  List<int> asList() => _mask.fold(
        [],
        (previousValue, element) => previousValue..addAll(element),
      );

  @override
  String toString() {
    return _mask.fold(
      '',
      (previousValue, element) => previousValue + '\n' + element.toString(),
    );
  }
}
