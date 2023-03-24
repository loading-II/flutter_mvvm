import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../common/net/WanHttp.dart';

class WanRepository {
  /*首页 Banner 列表*/
  static Future fetchBanner<T>(
      {CancelToken? cancelToken, required ValueChanged<T> onSuccess, required Function(int code, String message) onError}) async {
    const url = 'banner/json';
    return WanHttp.getInstance()
        .getRequest<T>(url: url, onSuccess: onSuccess, onError: onError, cancelToken: cancelToken, isShowLoading: false);
  }

  /*首页置顶文章列表*/
  static Future fetchTopArticle<T>(
      {CancelToken? cancelToken,
      required bool isShowLoading,
      required ValueChanged<T> onSuccess,
      required Function(int code, String message) onError}) async {
    const url = 'article/top/json';
    return WanHttp.getInstance()
        .getRequest<T>(url: url, onSuccess: onSuccess, onError: onError, cancelToken: cancelToken, isShowLoading: isShowLoading);
  }

  /*首页置顶文章列表*/
  static Future fetchArticle<T>(
      {required int index,
      required bool isShowLoading,
      CancelToken? cancelToken,
      required ValueChanged<T> onSuccess,
      required Function(int code, String message) onError}) async {
    final url = 'article/list/$index/json';
    return WanHttp.getInstance().getRequest<T>(
      url: url,
      onSuccess: onSuccess,
      onError: onError,
      cancelToken: cancelToken,
      isShowLoading: isShowLoading,
    );
  }

  /*获取文章体系列表*/
  static Future fetchArticleSys<T>(
      {CancelToken? cancelToken, required ValueChanged<T> onSuccess, required Function(int code, String message) onError}) async {
    const url = 'article/list/0/json';
    return WanHttp.getInstance()
        .getRequest<T>(url: url, queryParameters: {'cid': 60}, onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /*用户登录*/
  static Future userLogin<T>(
      {required String name,
      required String passwd,
      CancelToken? cancelToken,
      ValueChanged<T>? onSuccess,
      Function(int code, String message)? onError}) async {
    const url = 'user/login';
    return WanHttp.getInstance().postRequest(
        url: url,
        queryParameters: {'username': name, 'password': passwd},
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
}
