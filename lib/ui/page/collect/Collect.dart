import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/data/entity/collect_entity.dart';
import 'package:flutter_wanandroid/ui/page/collect/state/collect_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../data/http/WanUrls.dart';
import '../../../ext/NavExt.dart';
import '../../widget/Browser.dart';
import '../../widget/ListItem.dart';
import '../../widget/Refresh.dart';
import '../../widget/StatePage.dart';

class CollectVm extends BaseViewModel {
  late var refreshController = RefreshController();

  late final collectPageNotifier = newNotifier(CollectPageState());

  CollectPageState get _collectState => collectPageNotifier.state;

  set _collectState(CollectPageState state) {
    collectPageNotifier.state = state;
  }

  refresh() async {
    _refresh();
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

  retry() {
    refreshController.requestRefresh();
  }

  showFailedPage() {
    return httpState.isFail() && _collectState.datas.isEmpty;
  }

  int _getNextPage() {
    return _collectState.collectEntity?.curPage ?? 0;
  }

  _refresh() {
    _collectState.collectEntity?.curPage = 0;
  }

  _request() async {
    var value = await service.getCollectedArticle(page: _getNextPage());
    if (value != null) {
      var data = <CollectDatas>[];
      data.addAll(_collectState.datas);
      if (value.curPage == 1) {
        data.clear();
      }
      data.addAll(value.datas ?? []);
      _collectState = _collectState.copyWith(datas: data, collectEntity: value);
    }
  }
}

class CollectPage extends StatefulWidget {
  CollectPage({Key? key}) : super(key: key);

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  late var vm = CollectVm();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    vm.refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("收藏"),
        ),
        body: _collectContent());
  }

  _collectContent() {
    return Consumer(builder: (context, ref, _) {
      var data = vm.collectPageNotifier.watch(ref).datas;
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
                      shareUser: entity.author,
                      chapterName: entity.chapterName,
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
