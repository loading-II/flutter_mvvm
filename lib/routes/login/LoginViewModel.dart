import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';
import 'package:we_flutter/common/Logger.dart';
import 'package:we_flutter/common/net/HttpResult.dart';
import 'package:we_flutter/models/article_entity.dart';
import 'package:we_flutter/models/user_entity.dart';
import 'package:we_flutter/repository/WanRepository.dart';

final mLoginStateProvider = StateProvider.autoDispose<HttpResult<UserEntity>>((ref) {
  return HttpResult<UserEntity>(state: HttpResultState.Nothing);
});

class LoginViewModel extends BaseViewModel {
  late StateController<HttpResult<UserEntity>> mUserLoginStateController;
  final CancelToken _cancelToken = CancelToken();

  @override
  void doInit(BuildContext context, WidgetRef ref) {
    mUserLoginStateController = ref.watch(mLoginStateProvider.notifier);
  }

  @override
  void dispose() {
    _cancelToken.cancel();
  }

  void login(String name, String passwd) {
    WanRepository.userLogin<UserEntity>(
      name: name,
      passwd: passwd,
      cancelToken: _cancelToken,
      onSuccess: (UserEntity userEntity) {
        mUserLoginStateController.update((state) => HttpResult<UserEntity>(state: HttpResultState.OnSuccess, data: userEntity));
      },
      onError: (int code, String message) {
        mUserLoginStateController.update(
            (state) => HttpResult<UserEntity>(state: HttpResultState.OnError, error: HttpResultError(code: code, message: message)));
      },
    );
  }
}
