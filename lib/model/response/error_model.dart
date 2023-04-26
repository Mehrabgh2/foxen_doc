import '../../enum/server_error_type.dart';
import '../../util/app_util.dart';

class ErrorModel {
  final int code;
  final List<ErrorMessageModel> message;

  ErrorModel({
    required this.code,
    required this.message,
  });

  factory ErrorModel.withMessage(String message) {
    return ErrorModel(
      code: -1,
      message: [
        ErrorMessageModel(param: '', message: message),
      ],
    );
  }

  factory ErrorModel.withCode(int code) {
    return ErrorModel(
      code: code,
      message: [
        ErrorMessageModel(
          param: '',
          message: AppUtil.getCodeErrorMessage(code),
        )
      ],
    );
  }

  factory ErrorModel.fromJson(Map<String, dynamic> json, ServerErrorType type) {
    List<ErrorMessageModel> errors = List.empty(growable: true);
    List? serverErrors = json['errors'];
    if (serverErrors != null) {
      for (var element in serverErrors) {
        String error = '';
        String? param;
        if (element['name'] != null && element['name'] == 'param') {
          param = element['param'];
          List innerErrors = element['errors'] ?? List.empty();
          for (var element in innerErrors) {
            String finalError = AppUtil.getMessageErrorMessage(element, type);
            errors.add(ErrorMessageModel(param: param, message: finalError));
          }
        } else {
          error = AppUtil.getMessageErrorMessage(element['name'] ?? '', type);
        }
        if (error.isNotEmpty) {
          errors.add(ErrorMessageModel(param: param, message: error));
        }
      }
      return ErrorModel(code: -1, message: errors);
    } else if (json['err'] != null) {
      return ErrorModel(
        code: -1,
        message: [
          ErrorMessageModel(
            param: '',
            message: AppUtil.getMessageErrorMessage(json['err'], type),
          )
        ],
      );
    } else {
      return ErrorModel(
        code: -1,
        message: [
          ErrorMessageModel(
            param: '',
            message: 'عملیات با مشکل مواجه شد',
          )
        ],
      );
    }
  }

  @override
  String toString() {
    String errorString = '';
    for (var element in message) {
      if (errorString.isNotEmpty) {
        errorString = element.message;
      } else {
        errorString = element.message;
      }
    }
    return errorString.isNotEmpty
        ? errorString
        : 'code $code : with no message';
  }
}

class ErrorMessageModel {
  final String? param;
  final String message;

  ErrorMessageModel({
    required this.param,
    required this.message,
  });

  @override
  String toString() => message;
}
