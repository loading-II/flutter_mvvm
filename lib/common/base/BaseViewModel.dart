import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/src/consumer.dart';

///所有viewModel的父类，提供一些公共功能
abstract class BaseViewModel {
  bool _isFirst = true;

  bool get isFirst => _isFirst;

  @mustCallSuper
  void init(BuildContext context, WidgetRef ref) {
    if (_isFirst) {
      _isFirst = false;
      doInit(context, ref);
    }
  }

  @protected
  void doInit(BuildContext context, WidgetRef ref);

  void dispose();
}
