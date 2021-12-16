extension MatrixUtils on List<List<int>> {
  List<List<int>> operator *(List<List<int>> other) {
    assert(
      length == other.length,
      'The two matrices must have the same number of rows.',
    );
    assert(
      first.length == other.first.length,
      'The two matrices must have the same number of columns.',
    );

    return List<List<int>>.generate(
      length,
      (y) => List<int>.generate(first.length, (x) => this[y][x] * other[y][x]),
    );
  }

  // TODO: Add documentation
  List<int> get flat => fold<List<int>>(
        [],
        (List<int> result, List<int> row) => result..addAll(row),
      );
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
