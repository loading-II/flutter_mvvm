import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/base/BasePage.dart';
import '../../common/ViewModelProvider.dart';

import 'MineViewModel.dart';
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

class MinePage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MinePage.getRoutePage(const MinePage());
    }));
  }

  static ViewModelProvider<MineViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: MineViewModel(), child: child);
  }

  const MinePage({super.key});

  @override
  ConsumerState<MinePage> createState() => MinePageState();
}

class MinePageState extends BaseRoutePageState<MinePage> {
  MineViewModel? _viewModel;

  @override
  MineViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void onStateChange() {
    ref.listen(mMineStateProvider, (previous, next) {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MinePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'hello this is MinePage;',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void onLoad() {}
}
