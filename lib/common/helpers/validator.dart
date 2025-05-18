class Validators {
  static String? validatePhone(String? value) {
    final pattern = RegExp(r'^(05|٠٥)[0-9٠-٩]{8}$');
    if (value == null || !pattern.hasMatch(value)) return 'رقم غير صحيح';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'مطلوب';

    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
      caseSensitive: false,
      unicode: false,
    );

    if (!emailRegex.hasMatch(value)) {
      return 'بريد غير صالح';
    }

    return null;
  }

  static String? validateGpa(String? value, String gpaOutOf) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال المعدل';
    }

    final arabicToEnglishDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String normalizedValue = value.trim();
    arabicToEnglishDigits.forEach((arabicDigit, englishDigit) {
      normalizedValue = normalizedValue.replaceAll(arabicDigit, englishDigit);
    });

    final gpa = double.tryParse(normalizedValue);
    if (gpa == null) {
      return 'المعدل غير صالح';
    }

    final max = gpaOutOf == '5' ? 5.0 : 4.0;
    if (gpa < 0 || gpa > max) {
      return 'المعدل يجب أن يكون بين 0 و $max';
    }

    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'مطلوب';
    return null;
  }
}
