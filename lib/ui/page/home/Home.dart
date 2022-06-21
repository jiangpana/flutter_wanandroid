import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:flutter_wanandroid/ui/widget/StatePage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/BaseViewModel.dart';
import '../../../data/entity/article_list_entity.dart';
import '../../../http/WanUrls.dart';
import '../../widget/Browser.dart';
import '../../widget/Loading.dart';
import '../../widget/Refresh.dart';

class HomePageState {

  var datas = <ArticleListDatas>[];

  ArticleListEntity? articleListEntity;

  HomePageState.initial()
      :datas = <ArticleListDatas>[];

  HomePageState({ required this.datas, this.articleListEntity});

  HomePageState copyWith({
    datas,
    articleListEntity,
  }) {
    return HomePageState(
      datas: datas ?? this.datas,
      articleListEntity: articleListEntity ?? this.articleListEntity,
    );
  }

  int getNextPage() {
    return articleListEntity?.curPage ?? 0;
  }

  void refresh() {
    articleListEntity = null;
  }
}

class HomeVm extends BaseViewModel<HomePageState> {
  HomeVm([HomePageState? state]) : super(state ?? HomePageState.initial()) {}


  late final homePageNotifier = newNotifier(HomePageState.initial());
  HomePageState get _homeState => homePageNotifier.state;
  set _homeState(HomePageState state){
    homePageNotifier.state = state;
  }

  _request() async {
    var value = await service.httpGet<ArticleListEntity>(
        "${WanUrls.HOME_LIST}${ _homeState.getNextPage()}/json");
    if (value != null) {
      if (value.curPage == 1) {
        _homeState.datas.clear();
      }
      var data = <ArticleListDatas>[];
      data.addAll( _homeState.datas);
      data.addAll(value.datas ?? []);
      _homeState =
          _homeState.copyWith(datas: data, articleListEntity: value);
    }
  }

  _refresh() async {
    _homeState.refresh();
    await _request();
  }

  _loadMore() async {
    await _request();
  }
}

class HomeArListPage extends StatefulWidget {
  HomeArListPage({Key? key}) : super(key: key);

  @override
  _HomeArListPageState createState() => _HomeArListPageState();
}

class _HomeArListPageState extends State<HomeArListPage>
    with AutomaticKeepAliveClientMixin {
  late var refreshController = RefreshController();
  late var vm = HomeVm();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 初始化
    vm._refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(builder: (context, ref, _) {
      var data = vm.homePageNotifier
          .watch(ref)
          .datas;
      return refreshListStatePage(
          child: RefreshList(
              controller: refreshController,
              onRefresh: () async {
                print("onRefresh");
                await vm._refresh();
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await vm._loadMore();
                refreshController.loadComplete();
              },
              content: ListView.builder(
                itemBuilder: (c, index) =>
                    homeListItem(data[index], (item) {
                      navToPage(Browser(item.link!, item.title!));
                    }),
                itemExtent: 100.0,
                itemCount: data.length,
              )),
          empty: data.isEmpty,
          retry: () {
            print("retry");
            // vm._refresh();
            // vm.setHttpRequestState(HttpRequestState.Ready);
            refreshController.requestRefresh();
          });

/*      if (data.isEmpty) {
        return Center(child :CommonLoading(),);
      }
      return  RefreshList(
          controller: refreshController,
          onRefresh: () async {
            print("onRefresh");
            await vm._refresh();
            refreshController.refreshCompleted();
          },
          onLoading: () async {
            await vm._loadMore();
            refreshController.loadComplete();
          },
          content: ListView.builder(
            itemBuilder: (c, index) => homeListItem(data[index], (item) {
              navToPage(Browser(item.link!, item.title!));
            }),
            itemExtent: 100.0,
            itemCount: data.length,
          ));*/

    });
  }
}

homeListItem(ArticleListDatas item, Function(ArticleListDatas) callback) {
  return InkWell(
    onTap: () {
      callback.call(item);
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
                      "${item.shareUser ?? "xx"} , 分类: ${item
                          .superChapterName ?? ""}/${item.chapterName ?? ""}",
                      style: const TextStyle(
                          color: Colors.black54, fontSize: 13),
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
                      style: const TextStyle(
                          color: Colors.black54, fontSize: 13),
                    ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
