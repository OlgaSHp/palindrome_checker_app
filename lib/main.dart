import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/palindrome_screen.dart';
import 'package:provider/provider.dart';
import 'palindrome_controller.dart';

// Entry point of the Flutter application
void main() {
  // Initialize and run the app with Provider for state management
  runApp(
    // Wrap the app with ChangeNotifierProvider to provide PalindromeController
    ChangeNotifierProvider(
      // Create an instance of PalindromeController for the app
      create: (context) => PalindromeController(),
      // Set MyApp as the child widget
      child: const MyApp(),
    ),
  );
}

// Root widget defining the app's structure and theme
class MyApp extends StatelessWidget {
  // Constructor with an optional key for widget identification
  const MyApp({super.key});

  // Build method to define the app's UI structure
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget to configure the app
    return MaterialApp(
      // Disable the debug banner to remove the "DEBUG" ribbon
      debugShowCheckedModeBanner: false,
      // Set the app title for accessibility and system UI
      title: 'Palindrome Checker',
      // Define the app's theme
      theme: ThemeData(
        // Use blue as the primary color scheme
        primarySwatch: Colors.blue,
        // Enable Material 3 design for modern styling
        useMaterial3: true,
      ),
      // Set the PalindromeChecker widget as the home screen
      home: const PalindromeChecker(),
    );
  }
}
