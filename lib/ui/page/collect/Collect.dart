

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/data/entity/collect_entity.dart';
import 'package:flutter_wanandroid/ui/page/collect/state/collect_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../ext/NavExt.dart';
import '../../../http/WanUrls.dart';
import '../../widget/Browser.dart';
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


  int _getNextPage() {
    return _collectState.collectEntity?.curPage ?? 0;
  }

  _refresh() {
    _collectState.collectEntity?.curPage = 0;
  }



  _request() async {
    var value = await service.httpGet<CollectEntity>(
        "${WanUrls.COLLECTED_ARTICLE}${_getNextPage()}/json");
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
        body: _CollectContent());
  }

  _CollectContent() {
    return Consumer(builder: (context, ref, _) {
      var data = vm.collectPageNotifier
          .watch(ref)
          .datas;
      var httpState = vm.getHttpState(ref);
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
                itemBuilder: (c, index) =>
                    collectListItem(data[index], (item) {
                      navToPage(Browser(item.link!, item.title!));
                    }),
                itemExtent: 100.0,
                itemCount: data.length,
              )),
          fail: httpState.isFail(),
          retry: () {
            vm.retry();
          });
    });
  }
}
collectListItem(CollectDatas item, Function(CollectDatas) itemClick) {
  return InkWell(
    onTap: () {
      itemClick.call(item);
    },
    child: Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 4,
      borderOnForeground: false,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      // 外边距
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                item.title ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                Flexible(
                    child: Text(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "${item.author ?? "xx"} , 分类: ${item.chapterName ?? ""}",
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    )),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.blue,
                ),
                Flexible(
                    child: Text(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "${item.niceDate ?? ""}",
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
