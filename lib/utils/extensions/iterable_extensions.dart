import 'package:rxdart_state_management_article/utils/extensions/map_extensions.dart';

extension IterableExtensions<E> on Iterable<E> {
  bool hasSameElementsAs(Iterable<E>? other) {
    if (other == null || other.length != length) return false;

    var currentIterator = iterator;
    var otherIterator = other.iterator;

    while (currentIterator.moveNext() && otherIterator.moveNext()) {
      if (currentIterator.current is Iterable) {
        if ((currentIterator.current as Iterable)
                .hasSameElementsAs(otherIterator.current as Iterable) ==
            false) {
          return false;
        }
      } else if (currentIterator.current is Map) {
        if ((currentIterator.current as Map)
                .hasSameElementsAs(otherIterator.current as Map) ==
            false) {
          return false;
        }
      } else if (currentIterator.current != otherIterator.current) {
        return false;
      }
    }
    return true;
  }
}
