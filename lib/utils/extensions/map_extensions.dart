import 'package:rxdart_state_management_article/utils/extensions/iterable_extensions.dart';

extension MapExtensions<K, V> on Map<K, V> {
  bool hasSameElementsAs(Map<K, V>? other) {
    if (other == null || other.length != length) return false;

    var currentIterator = entries.iterator;
    while (currentIterator.moveNext()) {
      var currentValue = currentIterator.current;
      var otherValue = other[currentValue.key];
      if (otherValue == null ||
          otherValue.runtimeType != currentValue.value.runtimeType) {
        return false;
      }
      if (otherValue is Map) {
        if (!otherValue.hasSameElementsAs(currentValue.value as Map)) {
          return false;
        }
      } else if (otherValue is List) {
        if (!otherValue.hasSameElementsAs(currentValue.value as List)) {
          return false;
        }
      } else {
        if (otherValue != currentValue.value) {
          return false;
        }
      }
    }
    return true;
  }
}
