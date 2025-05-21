// Main UI widget for the palindrome checker
import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/palindrome_controller.dart';
import 'package:provider/provider.dart';

// Main UI widget for the palindrome checker
class PalindromeChecker extends StatefulWidget {
  const PalindromeChecker({super.key});

  @override
  State<PalindromeChecker> createState() => _PalindromeCheckerState();
}

// State class for managing the UI
class _PalindromeCheckerState extends State<PalindromeChecker> {
  // Controller for the input field
  final _textController = TextEditingController();

  // Clean up resources when widget is removed
  @override
  void dispose() {
    _textController.dispose(); // Dispose of the text controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome Checker'), // App title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding to content
        child: Column(
          children: [
            // Input field for entering words or phrases
            TextField(
              controller: _textController, // Bind text controller
              decoration: InputDecoration(
                labelText: 'Enter a word or phrase', // Placeholder text
                border: const OutlineInputBorder(), // Border style
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check), // Check button
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      Provider.of<PalindromeController>(
                        context,
                        listen: false,
                      ).checkPalindrome(_textController.text);
                      _textController.clear(); // Clear input after submission
                    }
                  },
                ),
              ),
              // Handle enter key submission
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  Provider.of<PalindromeController>(
                    context,
                    listen: false,
                  ).checkPalindrome(value);
                  _textController.clear(); // Clear input after submission
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
