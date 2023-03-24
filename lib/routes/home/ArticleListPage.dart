import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../common/Logger.dart';
import '../../common/ViewModelProvider.dart';
import '../../common/base/BasePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article_entity.dart';
import '../../models/banner_entity.dart';
import 'HomeViewModel.dart';

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

class ArticleListPage extends BaseRoutePage {
  static navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleListPage.getRoutePage(const ArticleListPage());
    }));
  }

  static ViewModelProvider<HomeViewModel> getRoutePage(BaseRoutePage child) {
    return ViewModelProvider(viewModel: HomeViewModel(), child: child);
  }

  const ArticleListPage({super.key});

  @override
  ConsumerState<ArticleListPage> createState() => ArticleListPageState();
}

class ArticleListPageState extends BaseRoutePageState<ArticleListPage> {
  HomeViewModel? _viewModel;

  @override
  HomeViewModel getViewModel() {
    _viewModel ??= ViewModelProvider.of(context);
    return _viewModel!;
  }

  @override
  void onLoad() {
    getViewModel().fetchTopArticle(true);
  }

  /// 下拉刷新方法,为list重新赋值
  Future _onRefresh() async {
    await getViewModel().fetchTopArticle(false);
  }

  Future _onLoadMore() async {
    if (getViewModel().mArticleCurPage < getViewModel().mArticlePageCount) {
      await getViewModel().fetchArticle(getViewModel().mArticleCurPage, false);
    } else {
      SmartDialog.showToast('没有更多了！');
    }
  }

  @override
  void onStateChange() {
    ref.listen(onLoadMoreStateProvider, (previous, next) {
        _onLoadMore();
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(children: [_getArticleView()]);
  }

  Widget _getArticleView() {
    List<ArticleDatas> articleList = ref.watch(mArticleStateProvider);
    return Expanded(
      //TODO： 暂时还不知如何去掉边界的阴影
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
            /*controller: _controller,*/
            itemBuilder: (BuildContext context, int index) {
              return _getArticleItem(articleList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 10,
                color: Colors.transparent,
              );
            },
            itemCount: articleList.length),
      ),
    );
  }

  Widget _getArticleItem(ArticleDatas articleDatas) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        width: 0.9 * mWidth,
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20), offset: const Offset(1.0, 1.0), blurRadius: 10.0, spreadRadius: 3.0),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                articleDatas.title,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
              ),
              Container(height: 10),
              Text(
                articleDatas.author.isEmpty ? articleDatas.shareUser : articleDatas.author,
                maxLines: 2,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
