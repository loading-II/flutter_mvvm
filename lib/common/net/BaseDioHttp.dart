import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../generated/json/base/json_convert_content.dart';

class HttpConfig {
  static const String WanBaseUrl = "https://www.wanandroid.com/";
  static const String BaiduUrl = "https://www.baidu.com/";
  static const Duration ConnectTimeout = Duration(milliseconds: 10000);
  static const Duration ReceiveTimeout = Duration(milliseconds: 50000);
}

abstract class BaseDioHttp extends DioForNative {
  BaseDioHttp() {
    options
      ..connectTimeout = HttpConfig.ConnectTimeout
      ..receiveTimeout = HttpConfig.ReceiveTimeout
      ..contentType = 'application/json'
      ..headers['platform'] = Platform.operatingSystem;

    interceptors
      ..add(_getPrettyLogger())
      ..add(_getRetryInterceptor())
      ..add(CommonHeaderInterceptors());
    init();
  }

  void init();

  _getRetryInterceptor() {
    return RetryInterceptor(
      dio: this,
      logPrint: print, // specify log function (optional)
      retries: 2, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 2), // wait 3 sec before third retry
      ],
    );
  }

  _getPrettyLogger() {
    return PrettyDioLogger(
        requestHeader: true, requestBody: true, responseBody: true, responseHeader: true, error: true, compact: true, maxWidth: 90);
  }

  String formatDioError(DioError error) {
    if (error.type == DioErrorType.connectionTimeout) {
      return "连接超时";
    } else if (error.type == DioErrorType.sendTimeout) {
      return "请求超时";
    } else if (error.type == DioErrorType.receiveTimeout) {
      return "响应超时";
    } else if (error.type == DioErrorType.badResponse) {
      return "错误状态码";
    } else if (error.type == DioErrorType.cancel) {
      return "请求取消";
    } else if (error.type == DioErrorType.badCertificate) {
      return "证书校验失败";
    } else if (error.type == DioErrorType.connectionError) {
      return "连接异常";
    } else if (error.type == DioErrorType.unknown) {
      return "未知异常";
    } else {
      return "";
    }
  }
}

class CommonHeaderInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['version'] = '1.2.3';

    /*String? tokenValue = MMKVHelper.getInstance().getTokenValue();
    if (tokenValue != null) {
      options.headers['token'] = tokenValue;
    }*/

    super.onRequest(options, handler);
  }
}

class BaseResponse<T> {
  int code = 0;
  String message = "";
  T? data;

  BaseResponse(this.code, this.message, this.data);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    code = json['errorCode'];
    message = json['errorMsg'];
  }

  bool isSuccess() => code == 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (this.data != null) {
      json['data'] = this.data;
    }
    json['code'] = this.code;
    json['message'] = this.message;
    return json;
  }
}
