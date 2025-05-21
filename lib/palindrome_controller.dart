import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/models/palindrome_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Save history to SharedPreferences
  Future<void> _saveHistory() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Convert history to JSON
    final historyJson = _history.map((check) => check.toJson()).toList();
    // Save JSON string to SharedPreferences
    await prefs.setString('palindrome_history', jsonEncode(historyJson));
  }

  // Check if an input string is a palindrome
  void checkPalindrome(String input) {
    // Ignore empty or whitespace-only inputs
    if (input.trim().isEmpty) return;

    // Clean input: convert to lowercase, remove non-alphanumeric characters
    final cleanedInput = input.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]'),
      '',
    );
    // Check if cleaned input equals its reverse
    final isPalindrome = cleanedInput == cleanedInput.split('').reversed.join();

    // Add new check to history (newest first)
    _history.insert(
      0,
      PalindromeCheck(
        input: input.trim(), // Store original trimmed input
        isPalindrome: isPalindrome, // Store palindrome result
        timestamp: DateTime.now(), // Record current time
      ),
    );

    // Set result message with emoji for SnackBar
    _lastResultMessage =
        isPalindrome
            ? '✅ "${input.trim()}" is a palindrome!'
            : '❌ "${input.trim()}" is not a palindrome.';
    // Set palindrome result for SnackBar color
    _lastResultIsPalindrome = isPalindrome;

    // Save updated history
    _saveHistory();
    // Notify listeners (UI) of state change
    notifyListeners();
  }

  // Clear the history and reset result state
  void clearHistory() {
    _history = []; // Reset history list
    _lastResultMessage = null; // Clear last result message
    _lastResultIsPalindrome = null; // Clear last result status
    // Save empty history
    _saveHistory();
    notifyListeners(); // Notify UI of state change
  }
}
