import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/BaseState.dart';
import '../../../base/BaseViewModel.dart';
import '../../../data/entity/article_list_entity.dart';
import '../../../http/WanService.dart';
import '../../../http/WanUrls.dart';
import '../../widget/Browser.dart';
import '../../widget/Refresh.dart';

class HomePageState {
  var curPage = 0;
  var datas = <ArticleListDatas>[];

  HomePageState.initial()
      : curPage = 0,
        datas = <ArticleListDatas>[];

  HomePageState({required this.curPage, required this.datas});

  HomePageState copyWith({
    curPage,
    datas,
  }) {
    return HomePageState(
      curPage: curPage ?? this.curPage,
      datas: datas ?? this.datas,
    );
  }
}

class HomeVm extends BaseViewModel<HomePageState> {

  HomeVm([HomePageState? state]) : super(state ?? HomePageState.initial()) {}

  _request() async {
    if (state.curPage == 0) {
      state.datas.clear();
    }
    var value = await service.httpGet<ArticleListEntity>(
        "${WanUrls.HOME_LIST}${state.curPage}/json");
    print(value?.datas?.first);
    var data = <ArticleListDatas>[];
    data.addAll(state.datas);
    data.addAll(value!.datas!);
    state = state.copyWith(datas: data);
  }

  _refresh() async {
    print("_refresh");
    state.curPage = 0;
    await _request();
  }

  _loadMore() async {
    print("_loadMore");
    state.curPage++;
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

  late final homeProvider =
      StateNotifierProvider<HomeVm, HomePageState>((ref) => vm);

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
    return Consumer(builder: (context, watch, _) {
      var data = watch.watch(homeProvider).datas;
      return RefreshList(
          controller: refreshController,
          onRefresh: () async {
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
          ));
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
            SizedBox(height: 10,),
          Row(children: [
            Icon(Icons.person,color: Colors.green,),
            Flexible(
                child: Text(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  "${item.shareUser ?? "xx"} , 分类: ${item.superChapterName ?? ""}/${item.chapterName ??""}",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                )),
            SizedBox(width: 8,),
            Icon(Icons.access_time,color: Colors.green,),
            Flexible(
                child: Text(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  "${item.niceDate ?? ""}",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ))
          ],),
          ],
        ),
      ),
    ),
  );
}
