extension IntMatrixUtils on List<List<int>> {
  List<int> get flat => [for (final line in this) ...line];
}

extension DoubleMatrixUtiles on List<List<double>> {
  List<List<double>> operator *(dynamic other) {
    if (other is double) {
      return map((row) => row.map((e) => e * other).toList()).toList();
    } else if (other is List<List<double>>) {
      if (other.length != length || other.first.length != first.length) {
        throw Exception('Matrix dimensions must agree');
      }

      return List<List<double>>.generate(
        length,
        (y) => List<double>.generate(
            first.length, (x) => this[y][x] * other[y][x]),
      );
    } else {
      throw Exception('${other.runtimeType} multiplication not supported');
    }
  }
}

extension ArrayUtils on List<int> {
  List<int> operator *(List<int> other) {
    assert(
      length == other.length,
      'The two arrays must have the same length.',
    );

    return List<int>.generate(
      length,
      (i) => this[i] * other[i],
    );
  }
}

int sum(int a, int b) => a + b;
double sumD(double a, double b) => a + b;

Iterable<int> range(int n) {
  return Iterable.generate(n);
}
