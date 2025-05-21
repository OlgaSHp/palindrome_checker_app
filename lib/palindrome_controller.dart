import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/models/palindrome_check.dart';

// Controller to manage palindrome checking logic and state
class PalindromeController extends ChangeNotifier {
  // Private list to store history of palindrome checks
  List<PalindromeCheck> _history = [];
  // Private string to store the last result message for SnackBar
  String? _lastResultMessage;
  // Private boolean to store the last palindrome result for SnackBar color
  bool? _lastResultIsPalindrome;

  // Public getter for history list
  List<PalindromeCheck> get history => _history;
  // Public getter for last result message
  String? get lastResultMessage => _lastResultMessage;
  // Public getter for last palindrome result
  bool? get lastResultIsPalindrome => _lastResultIsPalindrome;

  // Empty method to check if an input is a palindrome
  void checkPalindrome(String input) {}

  // Empty method to clear the history
  void clearHistory() {}
}
