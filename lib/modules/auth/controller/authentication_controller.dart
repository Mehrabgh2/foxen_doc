import 'package:flutter/cupertino.dart';
import 'package:foxenapp/util/app_util.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/constants_prefrences_controller.dart';
import '../../../controller/device_controller.dart';
import '../../../controller/foxen_user_controller.dart';
import '../../../enum/validator_enum.dart';
import '../../../model/request/forget_password_otp_request_model.dart';
import '../../../model/request/login_request_model.dart';
import '../../../model/request/signup_request_model.dart';
import '../../../model/response/check_license_response_model.dart';
import '../../../screen/main_screen.dart';
import '../../../service/auth_service.dart';
import '../../../util/auth_validator.dart';
import '../../../widget/dialog_box.dart';
import '../../../widget/overlay_toast.dart';
import '../../intro/screen/intro_screen.dart';
import '../forget_password/screen/forget_password_screen.dart';
import '../login/screen/login_screen.dart';
import '../signup/screen/signup_screen.dart';
import '../widget/count_down_timer.dart';

class AuthenticationController extends GetxController {
  static const int usernameMinChar = 5;
  static const int usernameMaxChar = 15;
  static const int passwordMinChar = 6;
  static const int passwordMaxChar = 15;
  static const int otpChar = 5;
  static const int countdownTime = 120;

  final FoxenUserController foxenUserController =
      Get.find<FoxenUserController>();
  final ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();

  PageController signupPageController = PageController();
  PageController forgetPasswordPageController = PageController();

  // login variables
  TextEditingController loginUsernameTextController = TextEditingController();
  TextEditingController loginPasswordTextController = TextEditingController();
  RxBool isLoginLoading = false.obs;
  RxBool isLoginUsernameError = false.obs;
  RxBool isLoginPasswordError = false.obs;
  RxBool isLoginServerError = false.obs;
  RxString loginErrorString = ''.obs;
  FocusNode loginPasswordFocus = FocusNode();

  // signup license variables
  TextEditingController signupVehicleNameTextController =
      TextEditingController();
  TextEditingController signupSerialTextController = TextEditingController();
  TextEditingController signupWarrantyTextController = TextEditingController();
  RxBool isSignupLicenseLoading = false.obs;
  RxBool isSignupLicenseVehicleNameError = false.obs;
  RxBool isSignupLicenseSerialError = false.obs;
  RxBool isSignupLicenseWarrantyError = false.obs;
  RxBool isSignupLicenseServerError = false.obs;
  RxString signupLicenseErrorString = ''.obs;

  // signup information variables
  TextEditingController signupFirstNameTextController = TextEditingController();
  TextEditingController signupLastNameTextController = TextEditingController();
  TextEditingController signupUsernameTextController = TextEditingController();
  TextEditingController signupPasswordTextController = TextEditingController();
  TextEditingController signupPhoneTextController = TextEditingController();
  RxBool isSignupOTPLoading = false.obs;
  RxBool isSignupStartLoading = false.obs;
  RxBool isSignupInformationFirstNameError = false.obs;
  RxBool isSignupInformationLastNameError = false.obs;
  RxBool isSignupInformationUsernameError = false.obs;
  RxBool isSignupInformationPasswordError = false.obs;
  RxBool isSignupInformationPhoneError = false.obs;
  RxBool isSignupInformationServerError = false.obs;
  RxString signupInformationErrorString = ''.obs;
  late CountDownTimer otpCountdown = CountDownTimer(
    onFinish: onFinishTimer,
  );
  FocusNode signupNameFocus = FocusNode();

  // signup OTP variables
  TextEditingController signupOTPTextController = TextEditingController();
  RxBool isSubmitOTPLoading = false.obs;
  RxBool canResendOTP = false.obs;
  RxBool isResendingOTP = false.obs;
  RxBool isSignupOTPError = false.obs;
  RxBool isSignupOTPServerError = false.obs;
  RxString signupOTPErrorString = ''.obs;
  FocusNode signupOtpFocus = FocusNode();

  // forget password phone variables
  TextEditingController forgetPasswordPhoneTextController =
      TextEditingController();
  RxBool isForgetPasswordPhoneLoading = false.obs;
  RxBool isForgetPasswordPhoneError = false.obs;
  RxBool isForgetPasswordPhoneServerError = false.obs;
  RxString forgetPasswordPhoneErrorString = ''.obs;

  // forget password OTP variables
  TextEditingController forgetPasswordOTPTextController =
      TextEditingController();
  RxBool isForgetPasswordOTPLoading = false.obs;
  RxBool canResendForgetOTP = false.obs;
  RxBool isForgetPasswordOTPError = false.obs;
  RxBool isForgetPasswordOTPServerError = false.obs;
  RxString forgetPasswordOTPErrorString = ''.obs;
  late CountDownTimer forgetPasswordOtpCountdown = CountDownTimer(
    onFinish: onFinishForgetTimer,
  );
  FocusNode forgetPasswordOtpFocus = FocusNode();

  // forget password new password variables
  TextEditingController forgetPasswordPasswordTextController =
      TextEditingController();
  TextEditingController forgetPasswordRepeatPasswordTextController =
      TextEditingController();
  RxBool isForgetPasswordNewPasswordLoading = false.obs;
  RxBool isForgetPasswordNewPasswordError = false.obs;
  RxBool isForgetPasswordRepeatPasswordError = false.obs;
  RxBool isForgetPasswordNewPasswordServerError = false.obs;
  RxString forgetPasswordNewPasswordErrorString = ''.obs;
  String resetPasswordToken = '';
  FocusNode forgetPasswordNewPasswordFocus = FocusNode();

  // logout
  RxBool isLogoutLoading = false.obs;

  void callSupport() {
    launchUrl(Uri.parse('tel:02158431'));
  }

  void goToSignup() {
    resetSignupLicenseScreen();
    resetSignupInformationScreen();
    resetSignupOTPScreen();
    Get.to(
      () => const SignupScreen(),
      transition: Transition.cupertinoDialog,
    );
  }

  void nextSignupPage() {
    if (signupPageController.page!.toInt() == 1) {
      setCanResendOTP(false);
      resetCountdownTimer();
    }
    signupPageController.animateToPage(
      signupPageController.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void previousSignupPage() {
    if (signupPageController.page!.toInt() == 0) {
      Get.back();
    }
    signupPageController.animateToPage(
      signupPageController.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void setSignupPage(int index) {
    signupPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void nextForgetPasswordPage() {
    if (forgetPasswordPageController.page!.toInt() == 0) {
      setCanResendForgetOTP(false);
      resetForgetPasswordCountdownTimer();
    }
    forgetPasswordPageController.animateToPage(
      forgetPasswordPageController.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void previousForgetPasswordPage() {
    if (forgetPasswordPageController.page!.toInt() == 0) {
      Get.back();
      loginPasswordFocus.requestFocus();
    }
    forgetPasswordPageController.animateToPage(
      forgetPasswordPageController.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void setForgetPasswordPage(int index) {
    forgetPasswordPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void login() async {
    if (validateLogin()) {
      setIsLogining(true);
      var userDataEither = await AuthService.login(
        LoginRequestModel(
          username: loginUsernameTextController.text,
          password: loginPasswordTextController.text,
        ),
      );
      userDataEither.fold(
        (user) {
          if (user.token != null) {
            clearLoginError();
            clearLoginErrorString();
            foxenUserController.setUser(user);
            _putController(user.token!);
            Get.off(
              () =>
                  constantsPrefrencesController.constant.value.introductionShown
                      ? MainScreen()
                      : IntroScreen(),
              transition: Transition.cupertinoDialog,
            );
          }
        },
        (error) {
          clearLoginError();
          setIsLoginServerError(true);
          setErrorString(loginErrorString, error.toString());
        },
      );
      setIsLogining(false);
    }
  }

  void signupCheckLicense() async {
    if (validateCheckLicense()) {
      setIsSignupLicensing(true);
      var checkDataEither = await AuthService.checkLicense(
        signupWarrantyTextController.text,
        signupSerialTextController.text,
      );
      checkDataEither.fold(
        (license) {
          if (license.check()) {
            clearSignupLicenseError();
            clearSignupLicenseErrorString();
            setSignupPage(1);
            signupNameFocus.requestFocus();
          } else {
            clearSignupLicenseError();
            setIsSignupLicenseServerError(true);
            setLicenseErrorString(license);
          }
        },
        (error) {
          clearSignupLicenseError();
          setIsSignupLicenseServerError(true);
          setErrorString(signupLicenseErrorString, error.toString());
        },
      );
      setIsSignupLicensing(false);
    }
  }

  void signup() async {
    if (validateSignup()) {
      setIsSignupOTPLoading(true);
      setCanResendOTP(false);
      resetCountdownTimer();
      var userDataEither = await AuthService.signup(
        SignupRequestModel(
          firstName: signupFirstNameTextController.text,
          lastName: signupLastNameTextController.text,
          username: signupUsernameTextController.text,
          password: signupPasswordTextController.text,
          vehicleName: signupVehicleNameTextController.text,
          phone: signupPhoneTextController.text,
          address: 'تهران',
          companyInfo: {},
          userType: 'users',
          deviceSerialNumber: signupSerialTextController.text,
          deviceWarrantyNumber: signupWarrantyTextController.text,
        ),
      );
      userDataEither.fold(
        (user) {
          resetSignupOTPScreen();
          clearSignupInformationError();
          clearSignupInformationErrorString();
          foxenUserController.setUser(user);
          setSignupPage(2);
          signupOtpFocus.requestFocus();
        },
        (error) {
          clearSignupInformationError();
          setIsSignupInformationServerError(true);
          setErrorString(signupInformationErrorString, error.toString());
        },
      );
      setIsSignupOTPLoading(false);
    }
  }

  void submitPhone() async {
    await DialogBox.showTurnOnBiometricDialog();
    if (validateOTP()) {
      setIsSubmitOTPLoading(true);
      var submitPhoneEither = await AuthService.submitOTP(
        int.parse(signupOTPTextController.text),
      );
      submitPhoneEither.fold(
        (verified) async {
          if (verified) {
            await DialogBox.showTurnOnBiometricDialog();
            if (foxenUserController.user.value!.token != null) {
              _putController(foxenUserController.user.value!.token!);
              Get.off(
                () => constantsPrefrencesController
                        .constant.value.introductionShown
                    ? MainScreen()
                    : IntroScreen(),
                transition: Transition.cupertinoDialog,
              );
            } else {
              OverlayToast.showFailureMessage('احراز هویت انجام نشد');
            }
          } else {
            clearSignupOTPError();
            clearSignupOTPErrorString();
            setIsSignupOTPServerError(true);
            signupOTPErrorString.value = 'کد وارد شده صحیح نمیباشد';
            signupOTPErrorString.refresh();
            update();
          }
        },
        (error) {
          clearSignupOTPError();
          setIsSignupOTPServerError(true);
          setErrorString(signupOTPErrorString, error.toString());
        },
      );
      setIsSubmitOTPLoading(false);
    }
  }

  void resendOTP() async {
    setIsResendingOTP(true);
    clearSignupOTPError();
    clearSignupOTPErrorString();
    var resendOTPEither = await AuthService.resendOTP();
    resendOTPEither.fold(
      (user) {
        OverlayToast.showSuccessMessage('کد احراز هویت برای شما ارسال شد');
        setCanResendOTP(false);
        resetCountdownTimer();
      },
      (error) {
        clearSignupOTPError();
        setIsSignupOTPServerError(true);
        setErrorString(signupOTPErrorString, error.toString());
      },
    );
    setIsResendingOTP(false);
  }

  void sendForgetOTP(bool isResend) async {
    if (validateForgetPasswordPhone()) {
      setIsForgetPasswordPhoneLoading(true);
      var forgetOTPEither = await AuthService.forgetPasswordSendOTP(
        forgetPasswordPhoneTextController.text,
      );
      forgetOTPEither.fold(
        (success) {
          clearForgetPasswordPhoneError();
          clearForgetPasswordPhoneErrorString();
          resetForgetPasswordOTPScreen();
          if (!isResend) {
            nextForgetPasswordPage();
            forgetPasswordOtpFocus.requestFocus();
          } else {
            setCanResendForgetOTP(false);
            resetForgetPasswordCountdownTimer();
          }
        },
        (error) {
          clearForgetPasswordPhoneError();
          setIsForgetPasswordPhoneServerError(true);
          setErrorString(forgetPasswordPhoneErrorString, error.toString());
        },
      );
      setIsForgetPasswordPhoneLoading(false);
    }
  }

  void submitForgetOTP() async {
    if (validateForgetPasswordOTP()) {
      setIsForgetPasswordOTPLoading(true);
      var submitForgetOTPEither = await AuthService.forgetPasswordSubmitOtp(
        ForgetPasswordOTPRequestModel(
          phone: forgetPasswordPhoneTextController.text,
          verifyKey: int.parse(forgetPasswordOTPTextController.text),
        ),
      );
      submitForgetOTPEither.fold(
        (token) {
          resetPasswordToken = token;
          clearForgetPasswordOTPError();
          clearForgetPasswordOTPErrorString();
          resetForgetPasswordNewPasswordScreen();
          nextForgetPasswordPage();
          forgetPasswordNewPasswordFocus.requestFocus();
        },
        (error) {
          clearForgetPasswordOTPError();
          setIsForgetPasswordOTPServerError(true);
          setErrorString(forgetPasswordOTPErrorString, error.toString());
        },
      );
      setIsForgetPasswordOTPLoading(false);
    }
  }

  void submitForgetNewPassword() async {
    if (validateForgetPasswordNewPassword()) {
      setIsForgetPasswordNewPasswordLoading(true);
      var submitNewPasswordEither =
          await AuthService.forgetPasswordResetPassword(resetPasswordToken,
              forgetPasswordRepeatPasswordTextController.text);
      submitNewPasswordEither.fold(
        (success) async {
          OverlayToast.showSuccessMessage('رمز عیور با موفقیت تغییر یافت');
          resetLoginScreen();
          Get.back();
        },
        (error) {
          clearForgetPasswordNewPasswordError();
          setIsForgetPasswordNewPasswordServerError(true);
          setErrorString(
              forgetPasswordNewPasswordErrorString, error.toString());
        },
      );
      setIsForgetPasswordNewPasswordLoading(false);
    }
  }

  void logout() {
    setIsLogoutLoading(true);
    foxenUserController.removeUser();
    removeController();
    Get.offAll(() => const LoginScreen());
    setIsLogoutLoading(false);
  }

  bool validateLogin() {
    bool usernameValidation =
        AuthValidator.emptyValidate(loginUsernameTextController.text);
    bool passwordValidation =
        AuthValidator.emptyValidate(loginPasswordTextController.text);
    clearLoginError();
    clearLoginErrorString();
    if (!usernameValidation) {
      setIsLoginUsernameError(true);
      setErrorString(
        loginErrorString,
        AppUtil.getAuthValidationError(
          AuthValidateEnum.empty,
          'نام کاربری',
          usernameMinChar,
          usernameMaxChar,
        ),
      );
    }
    if (!passwordValidation) {
      setIsLoginPasswordError(true);
      setErrorString(
        loginErrorString,
        AppUtil.getAuthValidationError(
          AuthValidateEnum.empty,
          'رمز عبور',
          passwordMinChar,
          passwordMaxChar,
        ),
      );
    }
    return (!isLoginPasswordError.value && !isLoginUsernameError.value);
  }

  bool validateCheckLicense() {
    AuthValidateEnum vehicleNameValidation =
        AuthValidator.signupVehicleNameValidate(
            signupVehicleNameTextController.text);
    AuthValidateEnum serialValidation =
        AuthValidator.deviceSerialValidate(signupSerialTextController.text);
    AuthValidateEnum warrantyValidation =
        AuthValidator.deviceWarrantyValidate(signupWarrantyTextController.text);
    clearSignupLicenseError();
    clearSignupLicenseErrorString();
    if (vehicleNameValidation != AuthValidateEnum.success) {
      setIsSignupLicenseVehicleNameError(true);
      setErrorString(
        signupLicenseErrorString,
        AppUtil.getAuthValidationError(
          vehicleNameValidation,
          'نام خودرو',
          0,
          0,
          true,
        ),
      );
    }
    if (serialValidation != AuthValidateEnum.success) {
      setIsSignupLicenseSerialError(true);
      setErrorString(
        signupLicenseErrorString,
        AppUtil.getAuthValidationError(
          serialValidation,
          'شماره سریال ردیاب',
          0,
          0,
          true,
        ),
      );
    }
    if (warrantyValidation != AuthValidateEnum.success) {
      setIsSignupLicenseWarrantyError(true);
      setErrorString(
        signupLicenseErrorString,
        AppUtil.getAuthValidationError(
          warrantyValidation,
          'کد گارانتی ردیاب',
          0,
          0,
          true,
        ),
      );
    }
    return (!isSignupLicenseVehicleNameError.value &&
        !isSignupLicenseSerialError.value &&
        !isSignupLicenseWarrantyError.value);
  }

  bool validateSignup() {
    AuthValidateEnum firstNameValidation =
        AuthValidator.firstNameValidate(signupFirstNameTextController.text);
    AuthValidateEnum lastNameValidation =
        AuthValidator.lastNameValidate(signupLastNameTextController.text);
    AuthValidateEnum usernameValidation =
        AuthValidator.usernameValidate(signupUsernameTextController.text);
    AuthValidateEnum passwordValidation =
        AuthValidator.passwordValidate(signupPasswordTextController.text);
    AuthValidateEnum phoneValidation =
        AuthValidator.phoneValidate(signupPhoneTextController.text);
    clearSignupInformationError();
    clearSignupInformationErrorString();
    if (firstNameValidation != AuthValidateEnum.success) {
      setIsSignupInformationFirstNameError(true);
      setErrorString(
        signupInformationErrorString,
        AppUtil.getAuthValidationError(
          firstNameValidation,
          'نام',
          usernameMinChar,
          usernameMaxChar,
        ),
      );
    }
    if (lastNameValidation != AuthValidateEnum.success) {
      setIsSignupInformationLastNameError(true);
      setErrorString(
        signupInformationErrorString,
        AppUtil.getAuthValidationError(
          lastNameValidation,
          'نام خانوادگی',
          usernameMinChar,
          usernameMaxChar,
        ),
      );
    }
    if (usernameValidation != AuthValidateEnum.success) {
      setIsSignupInformationUsernameError(true);
      setErrorString(
        signupInformationErrorString,
        AppUtil.getAuthValidationError(
          usernameValidation,
          'نام کاربری',
          usernameMinChar,
          usernameMaxChar,
        ),
      );
    }
    if (passwordValidation != AuthValidateEnum.success) {
      setIsSignupInformationPasswordError(true);
      setErrorString(
        signupInformationErrorString,
        AppUtil.getAuthValidationError(
          passwordValidation,
          'رمز عبور',
          passwordMinChar,
          passwordMaxChar,
        ),
      );
    }
    if (phoneValidation != AuthValidateEnum.success) {
      setIsSignupInformationPhoneError(true);
      setErrorString(
        signupInformationErrorString,
        AppUtil.getAuthValidationError(
          phoneValidation,
          'شماره موبایل',
          11,
          11,
          true,
        ),
      );
    }
    return (!isSignupInformationFirstNameError.value &&
        !isSignupInformationLastNameError.value &&
        !isSignupInformationUsernameError.value &&
        !isSignupInformationPasswordError.value &&
        !isSignupInformationPhoneError.value);
  }

  bool validateOTP() {
    AuthValidateEnum otpValidation =
        AuthValidator.otpValidate(signupOTPTextController.text);
    clearSignupOTPError();
    clearSignupOTPErrorString();
    if (otpValidation != AuthValidateEnum.success) {
      setIsSignupOTPError(true);
      setErrorString(
        signupOTPErrorString,
        AppUtil.getAuthValidationError(
          otpValidation,
          'کد تایید',
          otpChar,
          otpChar,
          true,
        ),
      );
    }
    return (!isSignupOTPError.value);
  }

  bool validateForgetPasswordPhone() {
    AuthValidateEnum phoneValidation =
        AuthValidator.phoneValidate(forgetPasswordPhoneTextController.text);
    bool isEmptyValidate =
        AuthValidator.emptyValidate(forgetPasswordPhoneTextController.text);
    clearForgetPasswordPhoneError();
    clearForgetPasswordPhoneErrorString();
    if (!isEmptyValidate) {
      setIsForgetPasswordPhoneError(true);
      setErrorString(forgetPasswordPhoneErrorString,
          '.لطفا شماره تلفن همراه خود را وارد کنید');
    } else if (phoneValidation != AuthValidateEnum.success) {
      setIsForgetPasswordPhoneError(true);
      setErrorString(
          forgetPasswordPhoneErrorString, '.کاربری با این شماره یافت نشد');
    }
    return (!isForgetPasswordPhoneError.value);
  }

  bool validateForgetPasswordOTP() {
    AuthValidateEnum otpValidation =
        AuthValidator.otpValidate(forgetPasswordOTPTextController.text);
    clearForgetPasswordOTPError();
    clearForgetPasswordOTPErrorString();
    if (otpValidation == AuthValidateEnum.empty) {
      setIsForgetPasswordOTPError(true);
      setErrorString(
        forgetPasswordOTPErrorString,
        '.لطفا کد تایید را وارد کنید',
      );
    } else if (otpValidation != AuthValidateEnum.success) {
      setIsForgetPasswordOTPError(true);
      setErrorString(
        forgetPasswordOTPErrorString,
        '.کد تایید وارد شده صحیح نیست',
      );
    }
    return (!isForgetPasswordOTPError.value);
  }

  bool validateForgetPasswordNewPassword() {
    AuthValidateEnum passValidation = AuthValidator.passwordValidate(
        forgetPasswordPasswordTextController.text);
    bool repeatPassValidation = AuthValidator.emptyValidate(
        forgetPasswordRepeatPasswordTextController.text);
    clearForgetPasswordNewPasswordError();
    clearForgetPasswordNewPasswordErrorString();
    if (passValidation != AuthValidateEnum.success) {
      setIsForgetPasswordNewPasswordError(true);
      setErrorString(
        forgetPasswordNewPasswordErrorString,
        AppUtil.getAuthValidationError(
          passValidation,
          ' رمز عبور جدید',
          passwordMinChar,
          passwordMaxChar,
        ),
      );
    } else if (!repeatPassValidation) {
      setIsForgetPasswordRepeatPasswordError(true);
      setErrorString(forgetPasswordNewPasswordErrorString,
          '.لطفا  تکرار  رمز عبور جدید خود را وارد کنید');
    }
    bool same = forgetPasswordPasswordTextController.text ==
        forgetPasswordRepeatPasswordTextController.text;
    bool allValidation = !isForgetPasswordNewPasswordError.value &&
        !isForgetPasswordRepeatPasswordError.value;
    if (allValidation) {
      if (!same) {
        setErrorString(
          forgetPasswordNewPasswordErrorString,
          '.رمز عبور با تکرار آن مغایرت دارد',
        );
        setIsForgetPasswordNewPasswordError(true);
        setIsForgetPasswordRepeatPasswordError(true);
      }
    }
    return (allValidation && same);
  }

  void editPhone() {
    resetSignupOTPScreen();
    setSignupPage(1);
  }

  void editForgetPhone() {
    resetForgetPasswordOTPScreen();
    setForgetPasswordPage(00);
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

  void setLicenseErrorString(CheckLicenseResponseModel license) {
    if (!license.found) {
      signupLicenseErrorString.value = '.دستگاهی یافت نشد';
    } else if (license.hasOwner) {
      signupLicenseErrorString.value = '.دستگاه قبلا ثبت شده است';
    }
    signupLicenseErrorString.refresh();
    update();
  }

  void goToForgetPassword() {
    resetForgetPasswordPhoneScreen();
    Get.to(
      () => const ForgetPasswordScreen(),
      transition: Transition.cupertinoDialog,
    );
  }

  void onFinishTimer() {
    setCanResendOTP(true);
  }

  void onFinishForgetTimer() {
    setCanResendForgetOTP(true);
  }

  void setCanResendOTP(bool value) {
    canResendOTP.value = value;
    canResendOTP.refresh();
    update();
  }

  void setCanResendForgetOTP(bool value) {
    canResendForgetOTP.value = value;
    canResendForgetOTP.refresh();
    update();
  }

  void resetForgetPasswordCountdownTimer() {
    forgetPasswordOtpCountdown.resetTimer();
  }

  void resetCountdownTimer() {
    otpCountdown.resetTimer();
  }

  void resetLoginScreen() {
    loginUsernameTextController.clear();
    loginPasswordTextController.clear();
    clearLoginError();
    clearLoginErrorString();
  }

  void resetSignupLicenseScreen() {
    clearSignupLicenseError();
    clearSignupLicenseErrorString();
    signupVehicleNameTextController.clear();
    signupWarrantyTextController.clear();
    signupSerialTextController.clear();
  }

  void resetSignupInformationScreen() {
    clearSignupInformationError();
    clearSignupInformationErrorString();
    signupFirstNameTextController.clear();
    signupLastNameTextController.clear();
    signupUsernameTextController.clear();
    signupPasswordTextController.clear();
    signupPhoneTextController.clear();
  }

  void resetSignupOTPScreen() {
    clearSignupOTPError();
    clearSignupOTPErrorString();
    signupOTPTextController.clear();
  }

  void resetForgetPasswordPhoneScreen() {
    clearForgetPasswordPhoneError();
    clearForgetPasswordPhoneErrorString();
    forgetPasswordPhoneTextController.clear();
  }

  void resetForgetPasswordOTPScreen() {
    clearForgetPasswordOTPError();
    clearForgetPasswordOTPErrorString();
    forgetPasswordOTPTextController.clear();
  }

  void resetForgetPasswordNewPasswordScreen() {
    clearForgetPasswordNewPasswordError();
    clearForgetPasswordNewPasswordErrorString();
    forgetPasswordPasswordTextController.clear();
    forgetPasswordRepeatPasswordTextController.clear();
  }

  void clearLoginError() {
    setIsLoginPasswordError(false);
    setIsLoginUsernameError(false);
    setIsLoginServerError(false);
  }

  void clearSignupLicenseError() {
    setIsSignupLicenseVehicleNameError(false);
    setIsSignupLicenseSerialError(false);
    setIsSignupLicenseWarrantyError(false);
    setIsSignupLicenseServerError(false);
  }

  void clearSignupInformationError() {
    setIsSignupInformationFirstNameError(false);
    setIsSignupInformationLastNameError(false);
    setIsSignupInformationUsernameError(false);
    setIsSignupInformationPasswordError(false);
    setIsSignupInformationPhoneError(false);
    setIsSignupInformationServerError(false);
  }

  void clearSignupOTPError() {
    setIsSignupOTPError(false);
    setIsSignupOTPServerError(false);
  }

  void clearForgetPasswordPhoneError() {
    setIsForgetPasswordPhoneError(false);
    setIsForgetPasswordPhoneServerError(false);
  }

  void clearForgetPasswordOTPError() {
    setIsForgetPasswordOTPError(false);
    setIsForgetPasswordOTPServerError(false);
  }

  void clearForgetPasswordNewPasswordError() {
    setIsForgetPasswordNewPasswordError(false);
    setIsForgetPasswordRepeatPasswordError(false);
    setIsForgetPasswordNewPasswordServerError(false);
  }

  void clearLoginErrorString() {
    loginErrorString.value = '';
    loginErrorString.refresh();
    update();
  }

  void clearSignupLicenseErrorString() {
    signupLicenseErrorString.value = '';
    signupLicenseErrorString.refresh();
    update();
  }

  void clearSignupInformationErrorString() {
    signupInformationErrorString.value = '';
    signupInformationErrorString.refresh();
    update();
  }

  void clearSignupOTPErrorString() {
    signupOTPErrorString.value = '';
    signupOTPErrorString.refresh();
    update();
  }

  void clearForgetPasswordPhoneErrorString() {
    forgetPasswordPhoneErrorString.value = '';
    forgetPasswordPhoneErrorString.refresh();
    update();
  }

  void clearForgetPasswordOTPErrorString() {
    forgetPasswordOTPErrorString.value = '';
    forgetPasswordOTPErrorString.refresh();
    update();
  }

  void clearForgetPasswordNewPasswordErrorString() {
    forgetPasswordNewPasswordErrorString.value = '';
    forgetPasswordNewPasswordErrorString.refresh();
    update();
  }

  void setIsLoginUsernameError(bool value) {
    isLoginUsernameError.value = value;
    isLoginUsernameError.refresh();
    update();
  }

  void setIsResendingOTP(bool value) {
    isResendingOTP.value = value;
    isResendingOTP.refresh();
    update();
  }

  void setIsLoginPasswordError(bool value) {
    isLoginPasswordError.value = value;
    isLoginPasswordError.refresh();
    update();
  }

  void setIsLoginServerError(bool value) {
    isLoginServerError.value = value;
    isLoginServerError.refresh();
    update();
  }

  void setIsSignupLicenseVehicleNameError(bool value) {
    isSignupLicenseVehicleNameError.value = value;
    isSignupLicenseVehicleNameError.refresh();
    update();
  }

  void setIsSignupLicenseSerialError(bool value) {
    isSignupLicenseSerialError.value = value;
    isSignupLicenseSerialError.refresh();
    update();
  }

  void setIsSignupLicenseWarrantyError(bool value) {
    isSignupLicenseWarrantyError.value = value;
    isSignupLicenseWarrantyError.refresh();
    update();
  }

  void setIsSignupLicenseServerError(bool value) {
    isSignupLicenseServerError.value = value;
    isSignupLicenseServerError.refresh();
    update();
  }

  void setIsSignupInformationFirstNameError(bool value) {
    isSignupInformationFirstNameError.value = value;
    isSignupInformationFirstNameError.refresh();
    update();
  }

  void setIsSignupInformationLastNameError(bool value) {
    isSignupInformationLastNameError.value = value;
    isSignupInformationLastNameError.refresh();
    update();
  }

  void setIsSignupInformationUsernameError(bool value) {
    isSignupInformationUsernameError.value = value;
    isSignupInformationUsernameError.refresh();
    update();
  }

  void setIsSignupInformationPasswordError(bool value) {
    isSignupInformationPasswordError.value = value;
    isSignupInformationPasswordError.refresh();
    update();
  }

  void setIsSignupInformationPhoneError(bool value) {
    isSignupInformationPhoneError.value = value;
    isSignupInformationPhoneError.refresh();
    update();
  }

  void setIsSignupOTPError(bool value) {
    isSignupOTPError.value = value;
    isSignupOTPError.refresh();
    update();
  }

  void setIsSignupInformationServerError(bool value) {
    isSignupInformationServerError.value = value;
    isSignupInformationServerError.refresh();
    update();
  }

  void setIsSignupOTPServerError(bool value) {
    isSignupOTPServerError.value = value;
    isSignupOTPServerError.refresh();
    update();
  }

  void setIsForgetPasswordPhoneError(bool value) {
    isForgetPasswordPhoneError.value = value;
    isForgetPasswordPhoneError.refresh();
    update();
  }

  void setIsForgetPasswordPhoneServerError(bool value) {
    isForgetPasswordPhoneServerError.value = value;
    isForgetPasswordPhoneServerError.refresh();
    update();
  }

  void setIsForgetPasswordOTPError(bool value) {
    isForgetPasswordOTPError.value = value;
    isForgetPasswordOTPError.refresh();
    update();
  }

  void setIsForgetPasswordOTPServerError(bool value) {
    isForgetPasswordOTPServerError.value = value;
    isForgetPasswordOTPServerError.refresh();
    update();
  }

  void setIsForgetPasswordNewPasswordError(bool value) {
    isForgetPasswordNewPasswordError.value = value;
    isForgetPasswordNewPasswordError.refresh();
    update();
  }

  void setIsForgetPasswordRepeatPasswordError(bool value) {
    isForgetPasswordRepeatPasswordError.value = value;
    isForgetPasswordRepeatPasswordError.refresh();
    update();
  }

  void setIsForgetPasswordNewPasswordServerError(bool value) {
    isForgetPasswordNewPasswordServerError.value = value;
    isForgetPasswordNewPasswordServerError.refresh();
    update();
  }

  void setIsLogining(bool value) {
    isLoginLoading.value = value;
    isLoginLoading.refresh();
    update();
  }

  void setIsSignupLicensing(bool value) {
    isSignupLicenseLoading.value = value;
    isSignupLicenseLoading.refresh();
    update();
  }

  void setIsSignupOTPLoading(bool value) {
    isSignupOTPLoading.value = value;
    isSignupOTPLoading.refresh();
    update();
  }

  void setIsSignupStartLoading(bool value) {
    isSignupStartLoading.value = value;
    isSignupStartLoading.refresh();
    update();
  }

  void setIsSubmitOTPLoading(bool value) {
    isSubmitOTPLoading.value = value;
    isSubmitOTPLoading.refresh();
    update();
  }

  void setIsForgetPasswordPhoneLoading(bool value) {
    isForgetPasswordPhoneLoading.value = value;
    isForgetPasswordPhoneLoading.refresh();
    update();
  }

  void setIsForgetPasswordOTPLoading(bool value) {
    isForgetPasswordOTPLoading.value = value;
    isForgetPasswordOTPLoading.refresh();
    update();
  }

  void setIsForgetPasswordNewPasswordLoading(bool value) {
    isForgetPasswordNewPasswordLoading.value = value;
    isForgetPasswordNewPasswordLoading.refresh();
    update();
  }

  void setIsLogoutLoading(bool value) {
    isLogoutLoading.value = value;
    isLogoutLoading.refresh();
    update();
  }

  void _putController(String token) async {
    Get.find<DeviceController>().init(token);
  }

  void removeController() {
    Get.find<DeviceController>().dismiss();
  }
}
