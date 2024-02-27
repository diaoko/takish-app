
class FormValidator {
  FormValidator._();

  static final _englishAlphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter user name';
    } else if (!_englishAlphaNumericRegex.hasMatch(value)) {
      return 'Only english character';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  static String? textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field should not be empty';
    } else {
      return null;
    }
  }
}
