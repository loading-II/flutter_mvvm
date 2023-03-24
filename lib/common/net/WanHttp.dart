import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path_provider/path_provider.dart';

import 'BaseDioHttp.dart';

class WanHttp extends BaseDioHttp {
  static WanHttp? _wanHttp;

  WanHttp._();

  static WanHttp getInstance() {
    _wanHttp ??= WanHttp._();
    return _wanHttp!;
  }

  @override
  void init() {
    options.baseUrl = HttpConfig.WanBaseUrl;
    /*interceptors.add(WanResponseIn());*/
    _configCooker();
  }

  void _configCooker() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    interceptors.add(CookieManager(PersistCookieJar(storage: FileStorage(appDocPath))));
  }

  Future getRequest<T>(
      {required String url,
      bool isShowLoading = true,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      required ValueChanged<T> onSuccess,
      required Function(int code, String message) onError}) async {
    if (isShowLoading) {
      SmartDialog.showLoading();
    }
    try {
      var response = await get(url, queryParameters: queryParameters, cancelToken: cancelToken);
      BaseResponse<T> responseEntity = BaseResponse.fromJson(response.data);

      if (responseEntity.isSuccess()) {
        T data = responseEntity.data as T;
        onSuccess(data);
        if (isShowLoading) {
          SmartDialog.dismiss();
        }
        return data;
      } else {
        /*onError(responseEntity.code, responseEntity.message);*/
        String message = formatErrorCode(responseEntity.code);
        onError(responseEntity.code, message);
        if (isShowLoading) {
          SmartDialog.dismiss();
        }
        return message;
      }
    } on DioError catch (error) {
      var errorMsg = formatDioError(error);
      onError(-1, errorMsg);
      if (isShowLoading) {
        SmartDialog.dismiss();
      }
      return errorMsg;
    }
  }

  Future postRequest<T>(
      {required String url,
      bool isShowLoading = true,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ValueChanged<T>? onSuccess,
      Function(int code, String message)? onError}) async {
    if (isShowLoading) {
      SmartDialog.showLoading();
    }

    try {
      var response = await post(url, queryParameters: queryParameters, cancelToken: cancelToken);
      BaseResponse<T> responseEntity = BaseResponse.fromJson(response.data);

      if (responseEntity.isSuccess()) {
        T data = responseEntity.data as T;
        if (onSuccess != null) {
          onSuccess(data);
        }
        if (isShowLoading) {
          SmartDialog.dismiss();
        }
        return data;
      } else {
        /*onError(responseEntity.code, responseEntity.message);*/
        String message = formatErrorCode(responseEntity.code);
        if (onError != null) {
          onError(responseEntity.code, message);
        }
        if (isShowLoading) {
          SmartDialog.dismiss();
        }
        return message;
      }
    } on DioError catch (error) {
      var errorMsg = formatDioError(error);
      if (onError != null) {
        onError(-1, errorMsg);
      }
      if (isShowLoading) {
        SmartDialog.dismiss();
      }
      return errorMsg;
    }
  }

  /*根据自己的业务需要统一管理 error code*/
  String formatErrorCode(int code) {
    switch (code) {
      case -1001:
        return "证书过期，请重新登录";
    }

    return "";
  }
}
