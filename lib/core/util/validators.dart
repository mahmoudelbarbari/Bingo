class Validators {
  static String? requiredField(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  static String? email(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return message ?? 'Enter a valid email';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? message}) {
    if (value == null || value.length < min) {
      return message ?? 'Minimum $min characters required';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? message}) {
    if (value != null && value.length > max) {
      return message ?? 'Maximum $max characters allowed';
    }
    return null;
  }

  static String? match(String? value, String? otherValue, {String? message}) {
    if (value != otherValue) {
      return message ?? 'Values do not match';
    }
    return null;
  }
}
