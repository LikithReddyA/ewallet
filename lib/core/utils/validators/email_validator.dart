class EmailValidator {
  // Prevent instantiation
  EmailValidator._();

  // Configuration
  static const int maxEmailLength = 254;

  // Error messages
  static const String requiredMessage = 'Email is required';
  static const String invalidMessage = 'Enter a valid email address';
  static const String maxLengthMessage = 'Email address is too long';
  static const String whitespaceMessage =
      'Email address must not contain spaces';

  // Industry-standard email regex
  //
  // Supports:
  // - subdomains
  // - plus addressing
  // - modern TLDs
  // - dots, underscores, hyphens
  //
  // Rejects:
  // - invalid formatting
  // - missing domain/TLD
  // - consecutive invalid symbols
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9]"
    r"(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9]"
    r"(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  static final RegExp _whitespaceRegex = RegExp(r'\s');

  /// Returns null if valid,
  /// otherwise returns validation error message.
  static String? validate(String? value) {
    // Null check
    if (value == null) {
      return requiredMessage;
    }

    // Trim leading/trailing spaces
    final email = value.trim();

    // Empty check
    if (email.isEmpty) {
      return requiredMessage;
    }

    // Length validation
    //
    // RFC-defined maximum email length:
    // 254 characters
    if (email.length > maxEmailLength) {
      return maxLengthMessage;
    }

    // Prevent whitespace
    if (_whitespaceRegex.hasMatch(email)) {
      return whitespaceMessage;
    }

    // Basic structure validation
    if (!_emailRegex.hasMatch(email)) {
      return invalidMessage;
    }

    // Additional validations

    // Must contain exactly one @
    if ('@'.allMatches(email).length != 1) {
      return invalidMessage;
    }

    final parts = email.split('@');

    if (parts.length != 2) {
      return invalidMessage;
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    // Local part max length: 64
    if (localPart.length > 64) {
      return invalidMessage;
    }

    // Domain must contain at least one dot
    if (!domainPart.contains('.')) {
      return invalidMessage;
    }

    // Prevent consecutive dots
    if (email.contains('..')) {
      return invalidMessage;
    }

    // Domain/TLD checks
    final domainSections = domainPart.split('.');

    // TLD validation
    final tld = domainSections.last;

    if (tld.length < 2) {
      return invalidMessage;
    }

    return null;
  }

  /// Optional helper method
  static bool isValid(String? value) {
    return validate(value) == null;
  }
}
