import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palindrome_checker_app/palindrome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:palindrome_checker_app/palindrome_controller.dart';

// Mock PalindromeController for controlled testing
class MockPalindromeController extends PalindromeController {
  MockPalindromeController() : super();
}

void main() {
  // Group tests for PalindromeChecker widget
  group('PalindromeChecker Widget Tests', () {
    // Declare controller for tests
    late MockPalindromeController controller;

    // Set up before each test
    setUp(() async {
      // Mock SharedPreferences to avoid MissingPluginException
      SharedPreferences.setMockInitialValues({});
      // Initialize controller
      controller = MockPalindromeController();
      // Wait for async initialization
      await Future.delayed(Duration.zero);
    });

    // Helper function to wrap widget with providers
    Widget buildTestWidget(Widget child) {
      return MaterialApp(
        home: ChangeNotifierProvider<PalindromeController>.value(
          value: controller,
          child: child,
        ),
      );
    }

    // Test that the UI renders correctly
    testWidgets('renders AppBar, input field, and empty history message', (
      WidgetTester tester,
    ) async {
      // Build the PalindromeChecker widget
      await tester.pumpWidget(buildTestWidget(const PalindromeChecker()));
      // Wait for async initialization and UI updates
      await tester.pump();

      // Verify AppBar title
      expect(find.text('Palindrome Checker'), findsOneWidget);
      // Verify input field placeholder
      expect(find.text('Enter a word or phrase'), findsOneWidget);
      // Verify empty history message
      expect(find.text('No history yet'), findsOneWidget);
      // Verify clear history button
      expect(find.byIcon(Icons.delete_sweep), findsOneWidget);
    });

    // Test submitting a palindrome shows correct SnackBar
    testWidgets('submitting palindrome shows green SnackBar', (
      WidgetTester tester,
    ) async {
      // Build the PalindromeChecker widget
      await tester.pumpWidget(buildTestWidget(const PalindromeChecker()));
      // Wait for async initialization
      await tester.pump();

      // Enter a palindrome in the input field
      await tester.enterText(find.byType(TextField), 'racecar');
      // Tap the check button
      await tester.tap(find.byIcon(Icons.check));
      // Wait for UI updates and SnackBar
      await tester.pumpAndSettle();

      // Verify SnackBar message
      expect(find.text('✅ "racecar" is a palindrome!'), findsOneWidget);
      // Verify SnackBar background color (green)
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, Colors.green);
    });

    // Test submitting a non-palindrome shows red SnackBar
    testWidgets('submitting non-palindrome shows red SnackBar', (
      WidgetTester tester,
    ) async {
      // Build the PalindromeChecker widget
      await tester.pumpWidget(buildTestWidget(const PalindromeChecker()));
      // Wait for async initialization
      await tester.pump();

      // Enter a non-palindrome in the input field
      await tester.enterText(find.byType(TextField), 'hello');
      // Tap the check button
      await tester.tap(find.byIcon(Icons.check));
      // Wait for UI updates and SnackBar
      await tester.pumpAndSettle();

      // Verify SnackBar message
      expect(find.text('❌ "hello" is not a palindrome.'), findsOneWidget);
      // Verify SnackBar background color (red)
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, Colors.red);
    });

    // Test history displays correctly after submission
    testWidgets('history displays input, timestamp, and icon', (
      WidgetTester tester,
    ) async {
      // Build the PalindromeChecker widget
      await tester.pumpWidget(buildTestWidget(const PalindromeChecker()));
      // Wait for async initialization
      await tester.pump();

      // Enter a palindrome
      await tester.enterText(find.byType(TextField), 'racecar');
      // Submit via check button
      await tester.tap(find.byIcon(Icons.check));
      // Wait for UI updates
      await tester.pumpAndSettle();

      // Verify history item input
      expect(find.text('racecar'), findsOneWidget);
      // Verify timestamp format (e.g., "Checked: May 21, 2025 12:49")
      expect(find.textContaining('Checked:'), findsOneWidget);
      // Verify green check icon
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    // Test clearing history resets to empty state
    testWidgets('clearing history shows empty state', (
      WidgetTester tester,
    ) async {
      // Build the PalindromeChecker widget
      await tester.pumpWidget(buildTestWidget(const PalindromeChecker()));
      // Wait for async initialization
      await tester.pump();

      // Add a history item
      await tester.enterText(find.byType(TextField), 'racecar');
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
      expect(find.text('racecar'), findsOneWidget);

      // Tap the clear history button
      await tester.tap(find.byIcon(Icons.delete_sweep));
      // Wait for UI updates
      await tester.pumpAndSettle();

      // Verify empty history message
      expect(find.text('No history yet'), findsOneWidget);
      // Verify history item is gone
      expect(find.text('racecar'), findsNothing);
    });
  });
}
