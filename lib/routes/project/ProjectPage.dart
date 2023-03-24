import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/base/BasePage.dart';
import '../../common/ViewModelProvider.dart';

import 'ProjectViewModel.dart';
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

class ProjectPage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProjectPage.getRoutePage(const ProjectPage());
    }));
  }

  static ViewModelProvider<ProjectViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: ProjectViewModel(), child: child);
  }

  const ProjectPage({super.key});

  @override
  ConsumerState<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends BaseRoutePageState<ProjectPage> {
  ProjectViewModel? _viewModel;

  @override
  void onLoad() {}

  @override
  ProjectViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void onStateChange() {
    ref.listen(mProjectStateProvider, (previous, next) {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProjectPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'hello this is ProjectPage;',
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
}
