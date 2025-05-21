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

  // Convert PalindromeCheck to JSON for storage in SharedPreferences
  Map<String, dynamic> toJson() => {
    'input': input,
    'isPalindrome': isPalindrome,
    'timestamp': timestamp.toIso8601String(),
  };

  // Create PalindromeCheck from JSON when loading from SharedPreferences
  factory PalindromeCheck.fromJson(Map<String, dynamic> json) =>
      PalindromeCheck(
        input: json['input'],
        isPalindrome: json['isPalindrome'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
