import 'package:dio/dio.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/logger.dart';

Map<String, dynamic> dioErrorHandle(DioError error) {
  UtilLogger.log("ERROR", error);

  switch (error.type) {
    case DioErrorType.response:
      UtilLogger.log("DioErrorType.response", error.response);
      if (error.response!.data is Map<String, dynamic>) {
        return error.response!.data;
      }
      return {"success": false, "message": "json_format_error"};
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return {"success": false, "message": "request_time_out"};

    default:
      return {"success": false, "message": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: Application.domain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  ///Setup Option
  BaseOptions exportOption(BaseOptions options) {
    UserModel? user = AppBloc.userCubit.state;
    if (user == null) {
      options.headers.remove("Authorization");
    } else {
      options.headers["Authorization"] = "Bearer token";
    }
    return options;
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data ?? formData);
    BaseOptions requestOptions = exportOption(baseOptions);
    UtilLogger.log("HEADERS", requestOptions.headers);

    Dio dio = Dio(requestOptions);
    try {
      final response = await dio.post(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (sent, total) {
          if (progress != null) {
            progress((sent / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    UtilLogger.log("GET URL", url);
    UtilLogger.log("PARAMS", params);
    BaseOptions requestOptions = exportOption(baseOptions);
    UtilLogger.log("HEADERS", requestOptions.headers);

    Dio dio = Dio(requestOptions);

    try {
      final response = await dio.get(
        url,
        queryParameters: params,
      );
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
