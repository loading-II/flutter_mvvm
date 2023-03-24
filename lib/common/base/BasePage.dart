import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';

import '../../routes/login/LoginPage.dart';
import '../../routes/login/LoginViewModel.dart';
import '../ViewModelProvider.dart';

abstract class BaseRoutePage extends ConsumerStatefulWidget {
  const BaseRoutePage({super.key});
}

abstract class BaseRoutePageState<T extends BaseRoutePage> extends ConsumerState<T> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @mustCallSuper
  BaseViewModel getViewModel();

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  void onLoad();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    getViewModel().init(context, ref);
    onStateChange();
    return buildContent(context);
  }

  void onStateChange();

  Widget buildContent(BuildContext context);

  @override
  void dispose() {
    getViewModel().dispose();
    super.dispose();
  }
}
