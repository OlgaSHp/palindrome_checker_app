// Main UI widget for the palindrome checker
import 'package:flutter/material.dart';

// Main UI widget for the palindrome checker
class PalindromChecker extends StatefulWidget {
  const PalindromChecker({super.key});

  @override
  State<PalindromChecker> createState() => _PalindromCheckerState();
}

// State class for managing the UI
class _PalindromCheckerState extends State<PalindromChecker> {
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
