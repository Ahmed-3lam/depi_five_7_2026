import 'package:depi_five/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Calculator", () {
    test("add Function", () {
      /// Arrange
      final calculator = Calculator();

      /// Act
      final result = calculator.add(2, 3);

      /// Assign
      expect(result, 5);
    });
 test("subtract Function", () {
      /// Arrange
      final calculator = Calculator();

      /// Act
      final result = calculator.subtract(5, 3);

      /// Assign
      expect(result,2);
    });

    test("multiply Function", () {
      /// Arrange
      final calculator = Calculator();

      /// Act
      final result = calculator.multiply(2, 3);

      /// Assign
      expect(result, 6);
    });

    test("divide Function", () {
      /// Arrange
      final calculator = Calculator();

      /// Act
      final result = calculator.divide(6, 3);

      /// Assign
      expect(result, 2);
    });
     test("divide Function", () {
      /// Arrange
      final calculator = Calculator();

      /// Act
      final result = calculator.divide(6, 3);

      /// Assign
      expect(result, 0);
    });

    // test("divide by zero throws ArgumentError", () {
    //   /// Arrange
    //   final calculator = Calculator();

    //   /// Act & Assert
    //   expect(() => calculator.divide(6, 0), throwsArgumentError);
    // });
 
  });
}
