import '../enum/validator_enum.dart';
import '../modules/auth/controller/authentication_controller.dart';

class AuthValidator {
  static AuthValidateEnum usernameValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else if (!minLengthValidate(
        text, AuthenticationController.usernameMinChar)) {
      return AuthValidateEnum.minLength;
    } else if (!maxLengthValidate(
        text, AuthenticationController.usernameMaxChar)) {
      return AuthValidateEnum.maxLength;
    } else if (!hasCharOrNumberValidate(text)) {
      return AuthValidateEnum.wrongJustEnglish;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum passwordValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else if (!minLengthValidate(
        text, AuthenticationController.passwordMinChar)) {
      return AuthValidateEnum.minLength;
    } else if (!maxLengthValidate(
        text, AuthenticationController.passwordMaxChar)) {
      return AuthValidateEnum.maxLength;
    } else if (!hasCharOrNumberValidate(text)) {
      return AuthValidateEnum.wrongPassword;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum repeatPasswordValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else if (!minLengthValidate(
        text, AuthenticationController.passwordMinChar)) {
      return AuthValidateEnum.minLength;
    } else if (!maxLengthValidate(
        text, AuthenticationController.passwordMaxChar)) {
      return AuthValidateEnum.maxLength;
    } else if (!hasCharOrNumberValidate(text)) {
      return AuthValidateEnum.wrongRepeatPassword;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum signupVehicleNameValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum deviceSerialValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum deviceWarrantyValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum firstNameValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum lastNameValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum phoneValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else if (!minLengthValidate(text, 11)) {
      return AuthValidateEnum.minLength;
    } else if (!maxLengthValidate(text, 11)) {
      return AuthValidateEnum.maxLength;
    } else if (!justNumberValidate(text)) {
      return AuthValidateEnum.wrongPhone;
    } else {
      return AuthValidateEnum.success;
    }
  }

  static AuthValidateEnum otpValidate(String text) {
    if (!emptyValidate(text)) {
      return AuthValidateEnum.empty;
    } else if (!minLengthValidate(text, AuthenticationController.otpChar)) {
      return AuthValidateEnum.minLength;
    } else if (!maxLengthValidate(text, AuthenticationController.otpChar)) {
      return AuthValidateEnum.maxLength;
    } else if (!justNumberValidate(text)) {
      return AuthValidateEnum.wrongOTP;
    } else {
      return AuthValidateEnum.success;
    }
  }

  // static bool hasCharAndNumberValidate(String text) {
  //   RegExp regExp = RegExp(
  //     "^(?=.*[a-zA-Z])(?=.*[0-9])",
  //     caseSensitive: false,
  //     multiLine: false,
  //   );
  //   bool firstRegex = regExp.hasMatch(text);
  //   bool secondRegex = hasCharOrNumberValidate(text);
  //   return firstRegex && secondRegex;
  // }

  static bool hasCharOrNumberValidate(String text) {
    RegExp regExp = RegExp(
      r"^[A-Za-z0-9!@#$%^&*()_+-=,./<>?]+$",
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.hasMatch(text);
  }

  static bool justNumberValidate(String text) {
    try {
      int temp = int.parse(text);
      if (temp >= 0) return true;
      return false;
    } catch (ex) {
      return false;
    }
  }

  static bool emptyValidate(String text) => text.isNotEmpty && text != '';

  static bool minLengthValidate(String text, int length) =>
      text.length >= length;

  static bool maxLengthValidate(String text, int length) =>
      text.length <= length;
}
