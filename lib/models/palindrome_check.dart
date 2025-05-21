// Define the PalindromeCheck model to store check details
class PalindromeCheck {
  final String input; // Original user input
  final bool isPalindrome; // Result of palindrome check
  final DateTime timestamp; // Time of the check

  PalindromeCheck({
    required this.input,
    required this.isPalindrome,
    required this.timestamp,
  });
}
