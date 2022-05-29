import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/utils/extensions/iterable_extensions.dart';

void main() {
  group("Test hasSameElementsAs extension", () {
    List<int> listWithInts = List.generate(10, (index) => index);

    List<String> listWithStrings =
        List.generate(10, (index) => index.toString());

    List<List<String>> listWithListOfStrings = List.generate(
        10, (index1) => List.generate(5, (index2) => "$index1-$index2"));

    List<List<List<String>>> listWithListOfListOfStrings = List.generate(
      10,
      (index1) => List.generate(
        5,
        (index2) => List.generate(3, (index3) => "$index1-$index2-$index3"),
      ),
    );

    List<List<Map<String, int>>> listWithListOfListOfMapOfStringAndInt =
        List.generate(
      10,
      (index1) => List.generate(
        5,
        (index2) => Map.fromEntries(List.generate(
            3, (index3) => MapEntry("$index1-$index2-$index3", index3))),
      ),
    );

    test('Test hasSameElementsAs on null', () {
      expect(
        listWithInts.hasSameElementsAs(null),
        false,
      );
    });

    test('Test hasSameElementsAs on null', () {
      expect(
        listWithInts.hasSameElementsAs([]),
        false,
      );
    });

    test('Test hasSameElementsAs on list with ints', () {
      expect(
        listWithInts.hasSameElementsAs(List.of(listWithInts)),
        true,
      );
    });

    test('Test hasSameElementsAs on list with strings', () {
      expect(
        listWithStrings.hasSameElementsAs(List.of(listWithStrings)),
        true,
      );
    });

    test('Test hasSameElementsAs on list with list of strings', () {
      expect(
        listWithListOfStrings.hasSameElementsAs(List.of(listWithListOfStrings)),
        true,
      );
    });

    test('Test hasSameElementsAs on list with list of list of strings', () {
      expect(
        listWithListOfListOfStrings
            .hasSameElementsAs(List.of(listWithListOfListOfStrings)),
        true,
      );
    });

    test('Test hasSameElementsAs on list with list of map of strings and ints',
        () {
      expect(
        listWithListOfListOfMapOfStringAndInt
            .hasSameElementsAs(List.of(listWithListOfListOfMapOfStringAndInt)),
        true,
      );
    });
  });
}
