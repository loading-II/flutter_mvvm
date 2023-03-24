import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:we_flutter/common/Global.dart';
import 'package:we_flutter/routes/home/HomePage.dart';
import 'package:we_flutter/routes/main/MainPage.dart';
import 'package:we_flutter/routes/welcome/WelcomePage.dart';
import 'package:we_flutter/states/GlobalStateProvider.dart';
import 'common/ViewModelProvider.dart';

class MyHttpOverrides extends HttpOverrides {
  final host = '192.168.1.101';
  final port = '8888';

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var http = super.createHttpClient(context);
    http.findProxy = (uri) {
      return 'PROXY $host:$port';
    };
    http.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return http;
  }
}

void main() {
  if (!kReleaseMode) {
    /*HttpOverrides.global = MyHttpOverrides();*/
  }
  Global.init().then((value) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MaterialColor themeColor = ref.watch(globalConfigProvider).themeColor;

    return MaterialApp(
      title: 'We wan flutter',
      theme: ThemeData(primarySwatch: themeColor),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      home: WelcomePage.getRoutePage(const WelcomePage()),
    );
  }
}
