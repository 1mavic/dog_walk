/// helper wrapper class
/// when using copyWith allows to make not null field null
class Wrapped<T> {
  /// consructor
  const Wrapped.value(this.value);

  /// value
  final T value;
}
