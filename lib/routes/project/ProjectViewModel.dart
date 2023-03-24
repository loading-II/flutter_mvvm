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

class ProjectStateEntity {
  final int id;
  final String name;

  ProjectStateEntity({required this.id, required this.name});

  ProjectStateEntity copyWith(int? id, String? name) {
    return ProjectStateEntity(id: id ?? this.id, name: name ?? this.name);
  }
}

final mProjectStateProvider = StateProvider.autoDispose<ProjectStateEntity>((ref) {
  return ProjectStateEntity(id: -1, name: 'Guoql');
});

class ProjectViewModel extends BaseViewModel {
  late StateController<ProjectStateEntity> mProjectStateController;

  @override
  void doInit(BuildContext context, WidgetRef ref) {
    mProjectStateController = ref.watch(mProjectStateProvider.notifier);
  }

  @override
  void dispose() {}

  void updateState(String name, String passwd) {
    mProjectStateController.update((state) => ProjectStateEntity(id: 110, name: 'update-name'));
  }

}

