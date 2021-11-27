class Tuple<T, S> {
  const Tuple(this._first, this._second);
  final T _first;
  final S _second;

  E? get<E>() {
    if (E == T) return _first as E;
    if (E == S) return _second as E;
    return null;
  }
}
