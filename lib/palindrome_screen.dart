// Main UI widget for the palindrome checker
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep), // Clear history icon
            onPressed: () {
              Provider.of<PalindromeController>(
                context,
                listen: false,
              ).clearHistory(); // Call controller to clear history
            },
            tooltip: 'Clear History', // Tooltip for accessibility
          ),
        ],
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
            const SizedBox(height: 16), // Spacer between input and history
            // History list with state updates
            Consumer<PalindromeController>(
              builder: (context, controller, child) {
                return Expanded(
                  child:
                      controller.history.isEmpty
                          ? const Center(
                            child: Text('No history yet'),
                          ) // Empty state
                          : ListView.builder(
                            itemCount: controller.history.length,
                            itemBuilder: (context, index) {
                              final check = controller.history[index];
                              return ListTile(
                                title: Text(check.input), // Show input
                                subtitle: Text(
                                  'Checked: ${DateFormat('MMM d, yyyy HH:mm').format(check.timestamp)}', // Show timestamp
                                ),
                                trailing: Icon(
                                  check.isPalindrome
                                      ? Icons.check_circle
                                      : Icons.cancel, // Icon based on result
                                  color:
                                      check.isPalindrome
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              );
                            },
                          ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
