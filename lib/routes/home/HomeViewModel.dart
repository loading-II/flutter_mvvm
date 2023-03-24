import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';

import '../../models/article_entity.dart';
import '../../models/banner_entity.dart';
import '../../repository/WanRepository.dart';

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

final mBannerStateProvider = StateProvider.autoDispose<List<BannerEntity>>((ref) {
  return List<BannerEntity>.empty();
});

final mArticleStateProvider = StateProvider.autoDispose<List<ArticleDatas>>((ref) {
  return List<ArticleDatas>.empty();
});

final onLoadMoreStateProvider = StateProvider.autoDispose<int>((ref) => -1);

class HomeViewModel extends BaseViewModel {
  late StateController<List<BannerEntity>> mBannerStateContorller;
  late StateController<List<ArticleDatas>> mArticleStateContorller;
  late StateController<int> onLoadMoreStateContorller;
  var mArticleCurPage = 0;
  var mArticlePageCount = 0;

  final CancelToken _cancelToken = CancelToken();

  @override
  void doInit(BuildContext context, WidgetRef ref) {
    mBannerStateContorller = ref.watch(mBannerStateProvider.notifier);
    mArticleStateContorller = ref.watch(mArticleStateProvider.notifier);
    onLoadMoreStateContorller = ref.watch(onLoadMoreStateProvider.notifier);
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    mBannerStateContorller.dispose();
    mArticleStateContorller.dispose();
    onLoadMoreStateContorller.dispose();
  }
  void sendLoadMoreState(){
    onLoadMoreStateContorller.update((state) => DateTime.now().microsecond);
  }

  void fetchBanner() {
    WanRepository.fetchBanner<List<BannerEntity>>(
      cancelToken: _cancelToken,
      onSuccess: (List<BannerEntity> bannerList) {
        mBannerStateContorller.update((state) => bannerList);
      },
      onError: (int code, String message) {},
    );
  }

  fetchTopArticle(bool isShowLoading) async {
    await WanRepository.fetchTopArticle<List<ArticleDatas>>(
      cancelToken: _cancelToken,
      isShowLoading: false,
      onSuccess: (List<ArticleDatas> articleData) {
        mArticleStateContorller.update((state) => articleData);
      },
      onError: (int code, String message) {},
    );

    fetchArticle(0, isShowLoading);
  }

  fetchArticle(int index, bool isShowLoading) async {
    await WanRepository.fetchArticle<ArticleEntity>(
      index: index,
      isShowLoading: isShowLoading,
      cancelToken: _cancelToken,
      onSuccess: (ArticleEntity articleEntity) {
        mArticleStateContorller.update((state) {
          return state + articleEntity.datas;
        });
        mArticlePageCount = articleEntity.pageCount;
        mArticleCurPage = articleEntity.curPage;
      },
      onError: (int code, String message) {},
    );
  }
}
