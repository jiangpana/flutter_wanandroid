import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/base/vm/BaseViewModel.dart';
import 'package:flutter_wanandroid/http/WanUrls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/entity/wenda_entity.dart';
import '../../../ext/NavExt.dart';
import '../../widget/Browser.dart';
import '../../widget/ListItem.dart';
import '../../widget/Loading.dart';
import '../../widget/Refresh.dart';
import '../../widget/StatePage.dart';

class QaState {
  WendaEntity? wendaEntity;
  var datas = <WendaDatas>[];

  QaState.initial() : datas = <WendaDatas>[];

  QaState({this.wendaEntity, required this.datas});

  int getNextPage() {
    return wendaEntity == null ? 0 : wendaEntity!.curPage! + 1;
  }

  void refresh() {
    wendaEntity = null;
  }

  QaState copyWith({
    wendaEntity,
    datas,
  }) {
    return QaState(
      wendaEntity: wendaEntity ?? this.wendaEntity,
      datas: datas ?? this.datas,
    );
  }
}

class QaViewModel extends BaseViewModel {
  late var refreshController = RefreshController();

  late final qaPageNotifier = newNotifier(QaState.initial());

  QaState get _qaState => qaPageNotifier.state;

  set _qaState(QaState state) {
    qaPageNotifier.state = state;
  }

  refresh() async {
    _qaState.refresh();
    await _request();
    if (httpState.isFail()) {
      refreshController.refreshFailed();
    } else {
      refreshController.refreshCompleted();
    }
  }

  loadMore() async {
    await _request();
    if (httpState.isFail()) {
      refreshController.loadFailed();
    } else {
      refreshController.loadComplete();
    }
  }

  void retry() {
    refreshController.requestRefresh();
  }

  _request() async {
    var value = await service
        .httpGet<WendaEntity>("${WanUrls.WENDA}${_qaState.getNextPage()}/json");
    if (value != null) {
      var data = <WendaDatas>[];
      data.addAll(_qaState.datas);
      if (value.curPage == 0) {
        data.clear();
      }
      data.addAll(value.datas ?? []);
      _qaState = _qaState.copyWith(datas: data, wendaEntity: value);
    }
  }

  showFailedPage() {
    return httpState.isFail() && _qaState.datas.isEmpty;
  }
}

class QaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QaPageState();
}

class _QaPageState extends State<QaPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var vm = QaViewModel();

  @override
  void initState() {
    super.initState();
    // 初始化
    vm.refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(builder: (context, ref, _) {
      var data = vm.qaPageNotifier.watch(ref).datas;
      var httpState = vm.watchHttpState(ref);
      return refreshListStatePage(
          child: RefreshList(
              controller: vm.refreshController,
              onRefresh: () async {
                await vm.refresh();
              },
              onLoading: () async {
                await vm.loadMore();
              },
              content: ListView.builder(
                itemBuilder: (c, index) {
                  final entity = data[index];
                  return commonListItem(
                      id: entity.id!,
                      title: entity.title,
                      shareUser: entity.shareUser,
                      chapterName: entity.superChapterName,
                      niceDate: entity.niceDate,
                      link: entity.link,
                      itemClick: () {
                        navToPage(Browser(entity.link!, entity.title!));
                      });
                },
                itemCount: data.length,
              )),
          fail: vm.showFailedPage(),
          retry: () {
            vm.retry();
          });
    });
  }
}
