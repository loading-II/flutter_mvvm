import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  static MaterialColor getThemeColoe() => themes[0];

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}

class GlobalConfig {
  final bool isRelease;
  final MaterialColor themeColor;

  GlobalConfig({required this.isRelease, required this.themeColor});

  GlobalConfig copyWith({bool? isRelease, MaterialColor? themeColor}) {
    return GlobalConfig(isRelease: isRelease ?? this.isRelease, themeColor: themeColor ?? this.themeColor);
  }
}

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];
