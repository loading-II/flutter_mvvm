import 'package:flutter/material.dart';
import 'package:we_flutter/common/AssetsHelper.dart';
import 'package:we_flutter/routes/login/LoginPage.dart';
import '../../common/base/BasePage.dart';
import '../../common/ViewModelProvider.dart';
import 'WelcomeViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 * #                                                   #
 * #                       _oo0oo_                     #
 * #                      o8888888o                    #
 * #                      88" . "88                    #
 * #                      (| -_- |)                    #
 * #                      0\  =  /0                    #
 * #                    ___/`---'\___                  #
 * #                  .' \\|     |# '.                 #
 * #                 / \\|||  :  |||# \                #
 * #                / _||||| -:- |||||- \              #
 * #               |   | \\\  -  #/ |   |              #
 * #               | \_|  ''\---/''  |_/ |             #
 * #               \  .-\__  '-'  ___/-. /             #
 * #             ___'. .'  /--.--\  `. .'___           #
 * #          ."" '<  `.___\_<|>_/___.' >' "".         #
 * #         | | :  `- \`.;`\ _ /`;.`/ - ` : | |       #
 * #         \  \ `_.   \_ __\ /__ _/   .-` /  /       #
 * #     =====`-.____`.___ \_____/___.-`___.-'=====    #
 * #                       `=---='                     #
 * #     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   #
 * #                                                   #
 * #               佛祖保佑         永无BUG              #
 * #                                                   #
 */

class WelcomePage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomePage.getRoutePage(const WelcomePage());
    }));
  }

  static ViewModelProvider<WelcomeViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: WelcomeViewModel(), child: child);
  }

  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends BaseRoutePageState<WelcomePage> {
  WelcomeViewModel? _viewModel;

  @override
  WelcomeViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void initState() {
    super.initState();
    getViewModel().layNavi(() {
      LoginPage.navigator(context);
    });
  }
  @override
  void onLoad() {
  }
  @override
  void onStateChange() {}

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(AssetsHelper.getPngImg(AssetsHelper.mSplashBg), fit: BoxFit.fitWidth),
      ),
    );
  }
}
