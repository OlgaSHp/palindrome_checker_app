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
    // Test palindrome detection for single words
    test('checkPalindrome detects palindrome correctly', () async {
      // Test a palindrome
      controller.checkPalindrome('racecar');
      expect(controller.history.first.isPalindrome, true);
      expect(controller.lastResultMessage, '✅ "racecar" is a palindrome!');
      expect(controller.lastResultIsPalindrome, true);

      // Test a non-palindrome
      controller.checkPalindrome('hello');
      expect(controller.history.first.isPalindrome, false);
      expect(controller.lastResultMessage, '❌ "hello" is not a palindrome.');
      expect(controller.lastResultIsPalindrome, false);
    });

    // Test palindrome detection for phrases with spaces and punctuation
    test(
      'checkPalindrome handles phrases with spaces and punctuation',
      () async {
        // Test a palindrome phrase
        controller.checkPalindrome('A man, a plan, a canal: Panama');
        expect(controller.history.first.isPalindrome, true);
        expect(
          controller.lastResultMessage,
          '✅ "A man, a plan, a canal: Panama" is a palindrome!',
        );

        // Test a non-palindrome phrase
        controller.checkPalindrome('Not a palindrome!');
        expect(controller.history.first.isPalindrome, false);
        expect(
          controller.lastResultMessage,
          '❌ "Not a palindrome!" is not a palindrome.',
        );
      },
    );
    // Test handling of empty or whitespace-only inputs
    test('checkPalindrome ignores empty or whitespace-only input', () async {
      // Test empty input
      controller.checkPalindrome('');
      expect(controller.history.isEmpty, true);
      expect(controller.lastResultMessage, isNull);
      expect(controller.lastResultIsPalindrome, isNull);

      // Test whitespace-only input
      controller.checkPalindrome('   ');
      expect(controller.history.isEmpty, true);
      expect(controller.lastResultMessage, isNull);
      expect(controller.lastResultIsPalindrome, isNull);
    });

    // Test history order (newest first)
    test('history maintains correct order', () async {
      // Add two checks
      controller.checkPalindrome('first');
      controller.checkPalindrome('second');
      // Verify length and order
      expect(controller.history.length, 2);
      expect(controller.history[0].input, 'second');
      expect(controller.history[1].input, 'first');
    });

    // Test clearing history
    test('clearHistory resets history and result', () async {
      // Add a check
      controller.checkPalindrome('test');
      expect(controller.history.isNotEmpty, true);

      // Clear history
      controller.clearHistory();
      // Verify history and results are reset
      expect(controller.history.isEmpty, true);
      expect(controller.lastResultMessage, isNull);
      expect(controller.lastResultIsPalindrome, isNull);
    });

    // Test history persistence with SharedPreferences
    test('history persists and loads correctly', () async {
      // Add a check
      controller.checkPalindrome('test');
      expect(controller.history.length, 1);
      expect(controller.history.first.input, 'test');

      // Simulate app restart by creating a new controller
      final newController = PalindromeController();
      // Wait for async initialization
      await Future.delayed(Duration.zero);
      // Verify history is loaded
      expect(newController.history.length, 1);
      expect(newController.history.first.input, 'test');
    });
  });
}
