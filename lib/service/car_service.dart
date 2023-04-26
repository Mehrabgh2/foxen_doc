import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:foxenapp/model/request/concox_command_request.dart';
import '../enum/server_error_type.dart';
import '../model/foxen_device.dart';
import '../model/request/add_odometer_request.dart';
import '../model/request/add_vehicle_request.dart';
import '../model/request/app_setting_request.dart';
import '../model/response/error_model.dart';
import '../model/response/notification_response.dart';
import '../model/response/odometer_history_response.dart';
import '../model/response/security_history_response.dart';
import '../util/app_util.dart';
import '../util/constants.dart';
import 'package:http/http.dart' as http;

class CarService {
  static const ServerErrorType type = ServerErrorType.car;

  static Future<Either<bool, ErrorModel>> bookmark(String id) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_BOOKMARK_URL}$id/true'),
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
      return Right(
          ErrorModel.withMessage('عملیات تغییر نشان ماشین با مشکل مواجه شد'));
    }
  }

  static Future<Either<SecurityHistoryResponse, ErrorModel>> getSecurityHistory(
    String id,
    int page,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_SECURITY_HISTORY_URL}$id/$page/timestamp/${Constants.paginationLimit}'),
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
        return Left(SecurityHistoryResponse.fromJson(json.decode(rec)));
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<FoxenDevice, ErrorModel>> addVehicle(
    AddVehicleRequest vehicleRequest,
  ) async {
    var request = http.Request(
      'POST',
      Uri.parse(Constants.BASE_URL + Constants.VEHICLE_ADD_URL),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(vehicleRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(FoxenDevice.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<OdometerHistory, ErrorModel>> addOdometer(
    AddOdometerRequest vehicleRequest,
  ) async {
    var request = http.Request(
      'POST',
      Uri.parse(Constants.BASE_URL + Constants.VEHICLE_ADD_ODOMETER_URL),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(vehicleRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(OdometerHistory.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<AppSettingRequest, ErrorModel>> setAppSetting(
      num vehicleId, AppSettingRequest settingRequest) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_APP_SETTING}/$vehicleId'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(settingRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(AppSettingRequest.fromJson(responseJson['appSetting']));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<Setting, ErrorModel>> setNotificationSetting(
      num vehicleId, Setting settingRequest) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_NOTIFICATION_SETTING}/$vehicleId'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(settingRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(Setting.fromJson(responseJson));
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<bool, ErrorModel>> setConcoxNotificationSetting(
      ConcoxCommandRequest settingRequest) async {
    var request = http.Request(
      'POST',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_CONCOX_NOTIFICATION_SETTING}'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(settingRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      if (response.statusCode == 200) {
        return const Left(true);
      }
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<OdometerHistoryResponse, ErrorModel>> getOdometerHistory(
    num id,
    int page,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_ODOMETER_HISTORY_URL}$id/$page/odometertimestamp/${Constants.paginationLimit}'),
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
      if (response.statusCode == 200) {
        return Left(OdometerHistoryResponse.fromJson(json.decode(rec)));
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<NotificationResponse, ErrorModel>> getAllNotifications(
    int page,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.GET_NOTIFICATIONS}$page/${Constants.paginationLimit}/0/1/0/23'),
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
      if (response.statusCode == 200) {
        return Left(NotificationResponse.fromJson(json.decode(rec)));
      }
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<bool, ErrorModel>> setVehicleIdentification(
      num vehicleId, Identification identificationRequest) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_IDENTIFICATION}/$vehicleId'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(identificationRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      if (response.statusCode == 200) {
        return const Left(true);
      }
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<bool, ErrorModel>> setVehicleClassification(
      num vehicleId, Classification classificationRequest) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.VEHICLE_CLASSIFICATION}/$vehicleId'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode(classificationRequest.toJson());
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      if (response.statusCode == 200) {
        return const Left(true);
      }
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<String?, ErrorModel>> setDeviceSimNumber(
      num vehicleId, String newSimNumber) async {
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Constants.BASE_URL}${Constants.DEVICE_SIM_NUMBER}/$vehicleId'),
    );
    Map<String, String>? headers = AppUtil().getHeaderWithToken();
    if (headers == null) {
      return Right(ErrorModel.withCode(0));
    }
    request.body = json.encode({"simno": newSimNumber});
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: Constants.requestTimeout),
          );
      final rec = (await http.Response.fromStream(response)).body;
      Map<String, dynamic> responseJson = json.decode(rec);
      if (response.statusCode == 200) {
        return Left(responseJson['newNo']);
      }
      return Right(ErrorModel.fromJson(responseJson, type));
    } on TimeoutException {
      return Right(ErrorModel.withCode(1));
    } catch (ex) {
      return Right(ErrorModel.withMessage('عملیات با مشکل مواجه شد'));
    }
  }
}
