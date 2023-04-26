import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:foxenapp/model/request/reset_password_request.dart';
import '../enum/server_error_type.dart';
import '../model/response/check_license_response_model.dart';
import '../model/response/error_model.dart';
import '../model/request/forget_password_otp_request_model.dart';
import '../model/foxen_user.dart';
import '../model/request/login_request_model.dart';
import '../model/request/signup_request_model.dart';
import '../util/app_util.dart';
import '../util/constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const ServerErrorType type = ServerErrorType.auth;

  static Future<Either<FoxenUser, ErrorModel>> refresh() async {
    var request = http.Request(
      'GET',
      Uri.parse(Constants.BASE_URL + Constants.GET_USER_INFO_URL),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(FoxenUser.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<FoxenUser, ErrorModel>> login(
      LoginRequestModel loginRequest) async {
    var request = http.Request(
      'POST',
      Uri.parse(Constants.BASE_URL + Constants.LOGIN_URL),
    );
    request.body = json.encode(loginRequest.toJson());
    Map<String, String> headers = AppUtil().getHeader();
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(FoxenUser.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<CheckLicenseResponseModel, ErrorModel>> checkLicense(
      String warranty, String serial) async {
    var request = http.Request(
      'GET',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.CHECK_LICENSE_URL}$warranty/$serial'),
    );
    Map<String, String> headers = AppUtil().getHeader();
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(CheckLicenseResponseModel.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<FoxenUser, ErrorModel>> signup(
      SignupRequestModel signupRequest) async {
    var request = http.Request(
      'POST',
      Uri.parse(Constants.BASE_URL + Constants.SIGNUP_URL),
    );
    request.body = json.encode(signupRequest.toJson());
    Map<String, String> headers = AppUtil().getHeader();
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 201) {
        return Left(FoxenUser.fromJson(responseJson['signIn']));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<bool, ErrorModel>> submitOTP(int code) async {
    var request = http.Request(
      'POST',
      Uri.parse(
          Constants.BASE_URL + Constants.VERIFY_OTP_URL + code.toString()),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(responseJson['isVerified']);
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<bool, ErrorModel>> resendOTP() async {
    var request = http.Request(
      'GET',
      Uri.parse(Constants.BASE_URL + Constants.VERIFY_OTP_URL),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      if (response.statusCode == 200) {
        return const Left(true);
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<bool, ErrorModel>> forgetPasswordSendOTP(
      String phone) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        Constants.BASE_URL + Constants.FORGET_PASSWORD_SEND_OTP_URL + phone,
      ),
    );
    Map<String, String> headers = AppUtil().getHeader();
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      if (response.statusCode == 200) {
        return const Left(true);
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<String, ErrorModel>> forgetPasswordSubmitOtp(
      ForgetPasswordOTPRequestModel forgetRequest) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        Constants.BASE_URL + Constants.FORGET_PASSWORD_SUBMIT_OTP_URL,
      ),
    );
    Map<String, String> headers = AppUtil().getHeader();
    request.headers.addAll(headers);
    request.body = json.encode(forgetRequest.toJson());
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(responseJson['token']);
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<bool, ErrorModel>> forgetPasswordResetPassword(
      String authToken, String password) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        Constants.BASE_URL + Constants.FORGET_PASSWORD_NEW_PASSWORD_URL,
      ),
    );
    Map<String, String> headers = AppUtil().getHeader();
    headers.addAll({
      'Authorization': 'Bearer $authToken',
    });
    request.headers.addAll(headers);
    request.body = json.encode({'password': password});
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      if (response.statusCode == 200) {
        return const Left(true);
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }

  static Future<Either<bool, ErrorModel>> resetPassword(
      ResetPasswordRequest rresetRquest) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
        Constants.BASE_URL + Constants.RESET_PASSWORD_NEW_PASSWORD_URL,
      ),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.headers.addAll(headers);
    request.body = json.encode(rresetRquest.toJson());
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      if (response.statusCode == 200) {
        return const Left(true);
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage(ex.toString()));
    }
  }
}
