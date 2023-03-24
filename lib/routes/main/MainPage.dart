import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_flutter/common/Logger.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';
import 'package:we_flutter/routes/home/HomePage.dart';
import 'package:we_flutter/routes/mine/MinePage.dart';
import 'package:we_flutter/routes/project/ProjectPage.dart';
import '../../common/base/BasePage.dart';
import '../../common/ViewModelProvider.dart';
import 'MainViewModel.dart';
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

class MainPage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainPage.getRoutePage(const MainPage());
    }));
  }

  static ViewModelProvider<MainViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: MainViewModel(), child: child);
  }

  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => MainPageState();
}

class MainPageState extends BaseRoutePageState<MainPage> {
  MainViewModel? _viewModel;
  late PageController _pageController;

  @override
  MainViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!;
      });
    });
  }

  @override
  void onLoad() {}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onStateChange() {}

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return mCurPages[index];
        },
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      bottomNavigationBar: _getBottomAppBar(),
    );
  }

  Widget _getBottomAppBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getBottomAppBarItem(true, 0),
          const SizedBox(), //中间位置空出
          _getBottomAppBarItem(false, 1),
          const SizedBox(), //中间位置空出
          _getBottomAppBarItem(false, 2),
        ], //均分底部导航栏横向空间
      ),
    );
  }

  Widget _getBottomAppBarItem(bool isSelected, int index) {
    return SizedBox(
      height: 44,
      child: _getItemIcon(index),
    );
  }

  double currentIndex = 0;
  final List<IconData> mBottomAppBarNormalIcon = [Icons.home, Icons.propane_tank, Icons.stars_outlined];
  final List<IconData> mBottomAppBarSelectedIcon = [Icons.add_link, Icons.add_link, Icons.add_link];
  final List<ViewModelProvider<BaseViewModel>> mCurPages = [
    HomePage.getRoutePage(const HomePage()),
    ProjectPage.getRoutePage(const ProjectPage()),
    MinePage.getRoutePage(const MinePage()),
  ];

  Widget _getItemIcon(int index) {
    return IconButton(
      icon: Icon((currentIndex.floor() == index) ? mBottomAppBarSelectedIcon[index] : mBottomAppBarNormalIcon[index]),
      onPressed: () {
        setState(() {
          _pageController.jumpToPage(index);
        });
      },
    );
  }
}
