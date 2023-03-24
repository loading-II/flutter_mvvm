import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:we_flutter/common/AssetsHelper.dart';
import 'package:we_flutter/routes/home/ArticleListPage.dart';
import '../../common/Logger.dart';
import '../../common/base/BasePage.dart';
import '../../common/ViewModelProvider.dart';
import '../../models/banner_entity.dart';
import 'HomeViewModel.dart';
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

class HomePage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage.getRoutePage(const HomePage());
    }));
  }

  static ViewModelProvider<HomeViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: HomeViewModel(), child: child);
  }

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends BaseRoutePageState<HomePage> with SingleTickerProviderStateMixin {
  HomeViewModel? _viewModel;
  late TabController tabController;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getViewModel().sendLoadMoreState();
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  HomeViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void onLoad() {
    getViewModel().fetchBanner();
  }

  @override
  void onStateChange() {}

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      body: buildNestedScrollView(),
    );
  }

  Widget buildNestedScrollView() {
    return NestedScrollView(
      controller: _controller,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [buildSliverAppBar()];
      },
      //页面的主体内容
      body: buidChildWidget(),
    );
  }

  Widget buidChildWidget() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ArticleListPage.getRoutePage(const ArticleListPage()),
      ],
    );
  }

  //SliverAppBar
  //flexibleSpace可折叠的内容区域
  buildSliverAppBar() {
    //SliverAppBar 属性大全：https://juejin.cn/post/6911498454757801997
    return SliverAppBar(
      //是否显示在状态栏的下面,false就会占领状态栏的高度
      primary: false,
      /*title: Text('topTitle'),*/
      //标题居中
      centerTitle: true,
      //当此值为true时 SliverAppBar 会固定在页面顶部
      //当此值为fase时 SliverAppBar 会随着滑动向上滑动
      pinned: false,
      //当值为true时 SliverAppBar设置的title会随着上滑动隐藏
      //然后配置的bottom会显示在原AppBar的位置
      //当值为false时 SliverAppBar设置的title会不会隐藏
      //然后配置的bottom会显示在原AppBar设置的title下面
      floating: true,
      //当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
      //反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
      snap: false,
      elevation: 0.0,
      //展开的高度
      expandedHeight: 200,
      //AppBar下的内容区域
      flexibleSpace: FlexibleSpaceBar(
        //背景
        //配置的是一个widget也就是说在这里可以使用任意的
        //Widget组合 在这里直接使用的是一个图片
        background: _getBannerView(),
      ),
      bottom: buildFlexibleTooBarWidget(),
    );
  }

  Widget _getBannerView() {
    List<BannerEntity> bannerList = ref.watch(mBannerStateProvider);
    return SizedBox(
      height: 200,
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.network(
            bannerList[index].imagePath,
            fit: BoxFit.fitWidth,
          );
        },
        itemCount: bannerList.length,
        loop: true,
        index: 0,
        autoplay: true,
        pagination: const SwiperPagination(),
        onTap: (index) {
          Log.i('on click $index');
        },
      ),
    );
  }

  //[SliverAppBar]的bottom属性配制
  PreferredSize buildFlexibleTooBarWidget() {
    //[PreferredSize]用于配置在AppBar或者是SliverAppBar
    //的bottom中 实现 PreferredSizeWidget
    return PreferredSize(
      //定义大小
      preferredSize: Size(MediaQuery.of(context).size.width, 0),
      //配置任意的子Widget
      child: Container(
        height: 0,
        alignment: Alignment.center,
        /*child: Container(
          color: Colors.transparent,
          //随着向上滑动，TabBar的宽度逐渐增大
          //父布局Container约束为 center对齐
          //所以程现出来的是中间x轴放大的效果
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            controller: tabController,
            tabs: const <Widget>[
              Tab(
                height: 0,
                text: "",
              ),
            ],
          ),
        ),*/
      ),
    );
  }
}
