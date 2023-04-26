import 'package:flutter/material.dart';
import 'package:foxenapp/enum/validator_enum.dart';
import 'package:foxenapp/model/request/reset_password_request.dart';
import 'package:foxenapp/modules/auth/controller/authentication_controller.dart';
import 'package:foxenapp/service/auth_service.dart';
import 'package:foxenapp/util/app_util.dart';
import 'package:foxenapp/util/auth_validator.dart';
import 'package:foxenapp/widget/overlay_toast.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();

  RxBool isOldPasswordError = false.obs;
  RxBool isNewPasswordError = false.obs;
  RxBool isRepeatNewPasswordError = false.obs;
  RxBool isServerError = false.obs;
  RxString newPasswordError = ''.obs;
  RxString repeatNewPasswordError = ''.obs;
  RxString errorString = ''.obs;
  RxBool isSubmitting = RxBool(false);

  void submit() async {
    if (validate()) {
      updateIsSubmitting(true);
      // var submitNewPasswordEither = await AuthService.resetPassword(
      //   ResetPasswordRequest(
      //     oldPassword: oldPasswordController.text,
      //     newPassword: newPasswordController.text,
      //   ),
      // );
      // submitNewPasswordEither.fold(
      //   (success) async {
      //     OverlayToast.showSuccessMessage('رمز عیور با موفقیت تغییر یافت');
      //     resetScreen();
      //     Get.back();
      //   },
      //   (error) {
      //     clearError();
      //     setIsServerError(true);
      //     setErrorString(errorString, error.toString());
      //   },
      // );
      updateIsSubmitting(false);
    }
  }

  bool validate() {
    bool oldPassValidation =
        AuthValidator.emptyValidate(oldPasswordController.text);
    AuthValidateEnum passValidation =
        AuthValidator.passwordValidate(newPasswordController.text);
    bool repeatPassValidation =
        AuthValidator.emptyValidate(repeatNewPasswordController.text);
    clearError();
    clearErrorString();
    if (!oldPassValidation) {
      setIsOldPasswordError(true);
      setErrorString(
        errorString,
        AppUtil.getAuthValidationError(
          AuthValidateEnum.empty,
          ' رمز عبور فعلی',
          AuthenticationController.passwordMinChar,
          AuthenticationController.passwordMaxChar,
        ),
      );
    }
    if (passValidation != AuthValidateEnum.success) {
      setIsNewPasswordError(true);
      setErrorString(
        errorString,
        AppUtil.getAuthValidationError(
          passValidation,
          ' رمز عبور جدید',
          AuthenticationController.passwordMinChar,
          AuthenticationController.passwordMaxChar,
        ),
      );
    } else if (!repeatPassValidation) {
      setIsRepeatPasswordError(true);
      setErrorString(
          errorString, '.لطفا  تکرار  رمز عبور جدید خود را وارد کنید');
    }
    bool same = newPasswordController.text == repeatNewPasswordController.text;
    bool allValidation =
        !isNewPasswordError.value && !isRepeatNewPasswordError.value;
    if (allValidation) {
      if (!same) {
        setErrorString(
          errorString,
          '.رمز عبور با تکرار آن مغایرت دارد',
        );
        setIsNewPasswordError(true);
        setIsRepeatPasswordError(true);
      }
    }
    return (allValidation && same);
  }

  void setErrorString(RxString host, String value) {
    if (host.value.isNotEmpty) {
      host.value = '${host.value}\n$value';
    } else {
      host.value = value;
    }
    host.refresh();
    update();
  }

  void setIsOldPasswordError(bool value) {
    isOldPasswordError.value = value;
    isOldPasswordError.refresh();
    update();
  }

  void setIsNewPasswordError(bool value) {
    isNewPasswordError.value = value;
    isNewPasswordError.refresh();
    update();
  }

  void setIsRepeatPasswordError(bool value) {
    isRepeatNewPasswordError.value = value;
    isRepeatNewPasswordError.refresh();
    update();
  }

  void setIsServerError(bool value) {
    isServerError.value = value;
    isServerError.refresh();
    update();
  }

  void resetScreen() {
    oldPasswordController.clear();
    newPasswordController.clear();
    repeatNewPasswordController.clear();
    clearError();
    clearErrorString();
  }

  void clearError() {
    setIsOldPasswordError(false);
    setIsNewPasswordError(false);
    setIsRepeatPasswordError(false);
  }

  void clearErrorString() {
    errorString.value = '';
    errorString.refresh();
    update();
  }

  void updateIsSubmitting(bool value) {
    isSubmitting.value = value;
    isSubmitting.refresh();
  }
}
