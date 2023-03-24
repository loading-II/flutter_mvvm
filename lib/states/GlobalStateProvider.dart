import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_flutter/common/Global.dart';

final globalConfigProvider = StateProvider.autoDispose<GlobalConfig>((ref) => GlobalConfig(
      isRelease: Global.isRelease,
      themeColor: Global.themes.first,
    ));
