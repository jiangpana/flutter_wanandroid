import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:flutter_wanandroid/ui/page/home/state/HomePageState.dart';
import 'package:flutter_wanandroid/ui/widget/StatePage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../data/entity/article_list_entity.dart';
import '../../../http/WanUrls.dart';
import '../../widget/Browser.dart';
import '../../widget/Refresh.dart';

class HomeVm extends BaseViewModel {

  late var refreshController = RefreshController();

  late final homePageNotifier = newNotifier(HomePageState());
  HomePageState get _homeState => homePageNotifier.state;

  set _homeState(HomePageState state) {
    homePageNotifier.state = state;
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
    return _homeState.articleListEntity?.curPage ?? 0;
  }

   _refresh() {
    _homeState.articleListEntity?.curPage = 0;
  }



  _request() async {
    var value = await service.httpGet<ArticleListEntity>(
        "${WanUrls.HOME_LIST}${_getNextPage()}/json");
    if (value != null) {
      var data = <ArticleListDatas>[];
      data.addAll(_homeState.datas);
      if (value.curPage == 1) {
        data.clear();
      }
      data.addAll(value.datas ?? []);
      _homeState = _homeState.copyWith(datas: data, articleListEntity: value);
    }
  }
}

class HomeArListPage extends StatefulWidget {
  HomeArListPage({Key? key}) : super(key: key);

  @override
  _HomeArListPageState createState() => _HomeArListPageState();
}

class _HomeArListPageState extends State<HomeArListPage>
    with AutomaticKeepAliveClientMixin {
  late var vm = HomeVm();

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
    return Consumer(builder: (context, ref, _) {
      var data = vm.homePageNotifier.watch(ref).datas;
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
                itemBuilder: (c, index) => homeListItem(data[index], (item) {
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

homeListItem(ArticleListDatas item, Function(ArticleListDatas) itemClick) {
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
                  "${item.shareUser ?? "xx"} , 分类: ${item.superChapterName ?? ""}/${item.chapterName ?? ""}",
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
