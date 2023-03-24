import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_flutter/common/base/BaseViewModel.dart';

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

class MineStateEntity {
  final int id;
  final String name;

  MineStateEntity({required this.id, required this.name});

  MineStateEntity copyWith(int? id, String? name) {
    return MineStateEntity(id: id ?? this.id, name: name ?? this.name);
  }
}

final mMineStateProvider = StateProvider.autoDispose<MineStateEntity>((ref) {
  return MineStateEntity(id: -1, name: 'Guoql');
});

class MineViewModel extends BaseViewModel {
  late StateController<MineStateEntity> mMineStateController;

  @override
  void doInit(BuildContext context, WidgetRef ref) {
    mMineStateController = ref.watch(mMineStateProvider.notifier);
  }

  @override
  void dispose() {}

  void updateState(String name, String passwd) {
    mMineStateController.update((state) => MineStateEntity(id: 110, name: 'update-name'));
  }

}

