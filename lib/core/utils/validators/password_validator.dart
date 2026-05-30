class PasswordValidator {
  // Prevent instantiation
  PasswordValidator._();

  // Configuration
  static const int minLength = 8;
  static const int maxLength = 64;

  // Error messages
  static const String requiredMessage = 'Password is required';
  static const String minLengthMessage =
      'Password must be at least 8 characters';
  static const String maxLengthMessage =
      'Password must not exceed 64 characters';
  static const String uppercaseMessage =
      'Password must contain at least 1 uppercase letter';
  static const String lowercaseMessage =
      'Password must contain at least 1 lowercase letter';
  static const String numberMessage = 'Password must contain at least 1 number';
  static const String specialCharMessage =
      'Password must contain at least 1 special character';
  static const String whitespaceMessage = 'Password must not contain spaces';

  // Regex patterns
  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'[0-9]');
  static final RegExp _specialCharRegex = RegExp(
    r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]',
  );
  static final RegExp _whitespaceRegex = RegExp(r'\s');

  /// Returns null if password is valid,
  /// otherwise returns validation error message.
  static String? validate(String? value) {
    // Null check
    if (value == null) {
      return requiredMessage;
    }

    // Trim leading/trailing spaces
    final password = value.trim();

    // Empty check
    if (password.isEmpty) {
      return requiredMessage;
    }

    // Length checks
    if (password.length < minLength) {
      return minLengthMessage;
    }

    if (password.length > maxLength) {
      return maxLengthMessage;
    }

    // Prevent whitespace inside password
    if (_whitespaceRegex.hasMatch(password)) {
      return whitespaceMessage;
    }

    // Character requirements
    if (!_uppercaseRegex.hasMatch(password)) {
      return uppercaseMessage;
    }

    if (!_lowercaseRegex.hasMatch(password)) {
      return lowercaseMessage;
    }

    if (!_numberRegex.hasMatch(password)) {
      return numberMessage;
    }

    if (!_specialCharRegex.hasMatch(password)) {
      return specialCharMessage;
    }

    return null;
  }

  /// Optional helper method
  /// Returns true if password passes validation
  static bool isValid(String? value) {
    return validate(value) == null;
  }
}
