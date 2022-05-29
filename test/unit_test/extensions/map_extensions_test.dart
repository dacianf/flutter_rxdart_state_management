import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/utils/extensions/map_extensions.dart';

void main() {
  group("Test hasSameElementsAs extension", () {
    Map<int, int> mapOfIntAndInt =
        Map.fromEntries(List.generate(10, (index) => MapEntry(index, index)));

    Map<String, int> mapOfStringAndInt = Map.fromEntries(
        List.generate(10, (index) => MapEntry(index.toString(), index)));

    Map<String, List<String>> mapOfStringAndListOfStrings = Map.fromEntries(
      List.generate(
        10,
        (index1) => MapEntry(
            index1.toString(), List.generate(5, (index2) => "$index1-$index2")),
      ),
    );

    Map<String, Map<String, int>> mapOfStringAndMapOfStringAndInt =
        Map.fromEntries(List.generate(
      10,
      (index1) => MapEntry(
        index1.toString(),
        Map.fromEntries(
            List.generate(5, (index2) => MapEntry("$index1-$index2", index2))),
      ),
    ));

    Map<String, Map<String, List<int>>> mapOfStringAndMapOfStringAndListOfInt =
        Map.fromEntries(List.generate(
      10,
      (index1) => MapEntry(
        index1.toString(),
        Map.fromEntries(List.generate(
            5,
            (index2) => MapEntry(
                  "$index1-$index2",
                  List.generate(3, (index) => index),
                ))),
      ),
    ));

    Map<List<String>, Map<String, List<int>>>
        mapOfListOfStringsAndMapOfStringAndListOfInt =
        Map.fromEntries(List.generate(
      10,
      (index1) => MapEntry(
        List.generate(5, (index) => index.toString()),
        Map.fromEntries(List.generate(
            5,
            (index2) => MapEntry(
                  "$index1-$index2",
                  List.generate(3, (index) => index),
                ))),
      ),
    ));

    Map<Map<String, int>, Map<String, List<int>>>
        mapOfMapOfStringAndIntAndMapOfStringAndListOfInt =
        Map.fromEntries(List.generate(
      10,
      (index1) => MapEntry(
        Map.fromEntries(List.generate(
            5,
            (index2) => MapEntry(
                  "$index1-$index2",
                  index2,
                ))),
        Map.fromEntries(List.generate(
            5,
            (index2) => MapEntry(
                  "$index1-$index2",
                  List.generate(3, (index) => index),
                ))),
      ),
    ));

    test('Test hasSameElementsAs on null', () {
      expect(
        mapOfIntAndInt.hasSameElementsAs(null),
        false,
      );
    });

    test('Test hasSameElementsAs on null', () {
      expect(
        mapOfIntAndInt.hasSameElementsAs({}),
        false,
      );
    });

    test('Test hasSameElementsAs on Map<int, int>', () {
      expect(
        mapOfIntAndInt.hasSameElementsAs(mapOfIntAndInt),
        true,
      );
    });

    test('Test hasSameElementsAs on Map<String, int>', () {
      expect(
        mapOfStringAndInt.hasSameElementsAs(mapOfStringAndInt),
        true,
      );
    });

    test('Test hasSameElementsAs on Map<String, List<String>>', () {
      expect(
        mapOfStringAndListOfStrings
            .hasSameElementsAs(mapOfStringAndListOfStrings),
        true,
      );
    });

    test('Test hasSameElementsAs on Map<String, Map<String, int>>', () {
      expect(
        mapOfStringAndMapOfStringAndInt
            .hasSameElementsAs(mapOfStringAndMapOfStringAndInt),
        true,
      );
    });

    test('Test hasSameElementsAs on Map<String, Map<String, List<int>>>', () {
      expect(
        mapOfStringAndMapOfStringAndListOfInt
            .hasSameElementsAs(mapOfStringAndMapOfStringAndListOfInt),
        true,
      );
    });

    test('Test hasSameElementsAs on Map<List<String>, Map<String, List<int>>>',
        () {
      expect(
        mapOfListOfStringsAndMapOfStringAndListOfInt
            .hasSameElementsAs(mapOfListOfStringsAndMapOfStringAndListOfInt),
        true,
      );
    });

    test(
        'Test hasSameElementsAs on Map<Map<String, int>, Map<String, List<int>>>',
        () {
      expect(
        mapOfMapOfStringAndIntAndMapOfStringAndListOfInt.hasSameElementsAs(
            mapOfMapOfStringAndIntAndMapOfStringAndListOfInt),
        true,
      );
    });
  });
}
