import 'package:flutter_test/flutter_test.dart';
import 'package:palindrome_checker_app/palindrome_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Group tests for PalindromeController
  group('PalindromeController', () {
    // Declare controller for tests
    late PalindromeController controller;

    // Set up before each test
    setUp(() async {
      // Mock SharedPreferences with empty initial values
      SharedPreferences.setMockInitialValues({});
      // Initialize controller
      controller = PalindromeController();
      // Wait for async initialization (e.g., _loadHistory)
      await Future.delayed(Duration.zero);
    });
  });
}
