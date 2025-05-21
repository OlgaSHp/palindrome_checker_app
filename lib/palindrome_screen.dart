// Main UI widget for the palindrome checker
import 'package:flutter/material.dart';

// Main UI widget for the palindrome checker
class PalindromeChecker extends StatefulWidget {
  const PalindromeChecker({super.key});

  @override
  State<PalindromeChecker> createState() => _PalindromeCheckerState();
}

// State class for managing the UI
class _PalindromeCheckerState extends State<PalindromeChecker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome Checker'), // App title
      ),
      body: Container(), // Empty body for now
    );
  }
}
