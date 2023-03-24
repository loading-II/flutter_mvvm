
class HttpResult<T> {
  final HttpResultState state;
  final T? data;
  final HttpResultError? error;

  HttpResult({required this.state, this.data, this.error});

  HttpResult copyWith(HttpResultState state, T? data, HttpResultError? error) {
    return HttpResult(state: state, data: data ?? this.data, error: error ?? this.error);
  }
}

enum HttpResultState { Nothing, OnSuccess, OnError }

class HttpResultError {
  final int code;
  final String message;

  HttpResultError({required this.code, required this.message});
}
