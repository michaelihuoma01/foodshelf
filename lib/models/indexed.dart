library more.iterable.indexed;

/// Returns a iterable that combines the index and value of an iterable.
///
/// By default the index is zero based, but an arbitrary [offset] can be
/// provided.
///
/// For example, the expression
///
///     indexed(['a', 'b'], offset: 1)
///       .map((each) => '${each.index}: ${each.value}')
///       .join(', ');
///
/// returns
///
///     '1: a, 2: b'
///
Iterable<Indexed<Image>> indexed<Image>(Iterable<Image> elements,
    {int offset = 0}) sync* {
  for (final element in elements) {
    yield Indexed<Image>(offset++, element);
  }
}

/// An indexed value.
class Indexed<Image> {
  final int index;
  final Image value;
  const Indexed(this.index, this.value);
}
