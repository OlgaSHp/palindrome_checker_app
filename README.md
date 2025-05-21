# Palindrome Checker

A Flutter app that allows users to check if a word or phrase is a palindrome. Features include:

- **Input Field**: Enter a word or phrase to check if it's a palindrome.
- **History**: Stores previous checks with timestamps, persisted across app restarts using `shared_preferences`.
- **Clear History**: Button to clear the history.
- **Feedback**: Shows a `SnackBar` with ✅ or ❌ to indicate palindrome status.
- **Unit Tests**: Tests for palindrome checking, history management, empty input handling, and persistence.

## Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/OlgaSHp/palindrome_checker_app.git
   cd palindrome_checker
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run tests:
   ```bash
   flutter test
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies
- `provider`: State management
- `intl`: Timestamp formatting
- `shared_preferences`: Persistent storage
- `test`: Unit testing

## Structure
- `lib/main.dart`: App entry point with Provider setup
- `lib/models/palindrome_check.dart`: Data model for palindrome checks
- `lib/palindrome_controller.dart`: Logic for palindrome checking and history
- `lib/palindrome_screen.dart`: UI with input field and history list
- `test/palindrome_controller_test.dart`: Unit tests for PalindromeController
- `test/palindrome_screen_test.dart`: Widget tests for PalindromeChecker

## Usage
- Enter a word/phrase in the input field and press the check button or enter.
- View the history of checks with timestamps and results.
- Click the clear history button to reset the history.

## Testing
- Run `flutter test` to execute unit tests, which cover:
  - Palindrome detection for words and phrases
  - Handling empty or whitespace-only inputs
  - History order (newest first)
  - Clearing history
  - Persistence of history using `shared_preferences`