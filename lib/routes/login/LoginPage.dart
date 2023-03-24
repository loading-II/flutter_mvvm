import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:we_flutter/common/Logger.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';
import 'package:we_flutter/common/net/HttpResult.dart';
import 'package:we_flutter/repository/WanRepository.dart';
import 'package:we_flutter/routes/main/MainPage.dart';
import '../../common/Global.dart';
import '../../common/ViewModelProvider.dart';
import '../../common/base/BasePage.dart';
import '../../models/user_entity.dart';
import '../../states/GlobalStateProvider.dart';
import '../../widgets/CircleButton.dart';
import '../../widgets/CustomClipper.dart';
import 'LoginViewModel.dart';

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

class LoginPage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
      return LoginPage.getRoutePage(const LoginPage(title: 'this is login page'));
    }));
  }

  static ViewModelProvider<LoginViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: LoginViewModel(), child: child);
  }

  const LoginPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends BaseRoutePageState<LoginPage> {
  LoginViewModel? _viewModel;
  final TextEditingController _mNameController = TextEditingController();
  final TextEditingController _mPwdController = TextEditingController();
  final GlobalKey _mFormKey = GlobalKey<FormState>();

  @override
  LoginViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }
  @override
  void onLoad() {
  }
  @override
  void onStateChange() {
    ref.listen(mLoginStateProvider, (previous, next) {
      switch (next.state) {
        case HttpResultState.OnSuccess:
          MainPage.navigator(context);
          break;
        case HttpResultState.OnError:
          SmartDialog.showToast("${next.error?.message}");
          break;
        case HttpResultState.Nothing:
          break;
      }
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              _getTopBg(),
              _getLoginPlate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTopBg() {
    return ClipPath(
      clipper: BottomCircleClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _getLoginPlate() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Form(
        key: _mFormKey, //设置globalKey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
            // padding: EdgeInsets.only(top: mHeight / 4),
            child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("wan android", style: TextStyle(fontSize: 28, color: Colors.white)),
                const Padding(padding: EdgeInsets.only(top: 45)),
                Container(
                  width: mWidth * 0.85,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      color: Theme.of(context).cardColor,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor.withAlpha(20),
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            spreadRadius: 3.0),
                      ]),
                  child: Column(
                    children: [
                      _getInputTextFormField("UserName", _mNameController, "please input user name", const Icon(Icons.person), false, (v) {
                        return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      }),
                      _getInputTextFormField("PassWord", _mPwdController, "please input password", const Icon(Icons.lock), true, (v) {
                        return v!.trim().length > 5 ? null : "密码不能少于6位";
                      }),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      CircleButton(const Text("Login"), () {
                        if ((_mFormKey.currentState as FormState).validate()) {
                          getViewModel().login('flutter_mvvm', 'flutter_mvvm');
                        } else {
                          SmartDialog.showToast("验证未通过");
                        }
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Widget _getInputTextFormField(String labeText, TextEditingController mController, String hintText, Widget prefixIcon, bool isObscureText,
      Function(dynamic v) param4) {
    var color = Theme.of(context).primaryColor.withAlpha(255);
    return TextFormField(
      autofocus: false,
      controller: mController,
      textAlign: TextAlign.start,
      maxLines: 1,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: labeText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
      ),
      validator: (v) {
        return param4(v);
      },
    );
  }
}
