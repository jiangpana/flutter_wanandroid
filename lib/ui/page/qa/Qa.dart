import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/base/BaseViewModel.dart';
import 'package:flutter_wanandroid/http/WanUrls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/entity/wenda_entity.dart';
import '../../../ext/NavExt.dart';
import '../../widget/Browser.dart';
import '../../widget/Loading.dart';
import '../../widget/Refresh.dart';
import '../../widget/StatePage.dart';

class QaState {

  WendaEntity? wendaEntity;
  var datas = <WendaDatas>[];

  QaState.initial()
      :
        datas = <WendaDatas>[];

  QaState({ this.wendaEntity, required this.datas});

  int getNextPage() {
    return wendaEntity?.curPage ?? 0;
  }

  void refresh() {
    wendaEntity =null;
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

class QaViewModel extends BaseViewModel<QaState> {
  QaViewModel(super.state);

  _request() async {

    var value = await service
        .httpGet<WendaEntity>("${WanUrls.WENDA}${state.getNextPage()}/json");
   if(value !=null){
     if (value.curPage == 1) {
       state.datas.clear();
     }
     var data = <WendaDatas>[];
     data.addAll(state.datas);
     data.addAll(value.datas!);
     state = state.copyWith(datas: data,wendaEntity: value);
   }
  }

  _refresh() async {
    state.refresh();
    await _request();
  }

  _loadMore() async {
    await _request();
  }
}

class QaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QaPageState();
}

class _QaPageState extends State<QaPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var refreshController = RefreshController();

  late var vm = QaViewModel(QaState.initial());

  late final homeProvider =
      StateNotifierProvider<QaViewModel, QaState>((ref) => vm);

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
      return refreshListStatePage(
          child: RefreshList(
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
              )),
          empty: data.isEmpty,
          retry: () {
            print("retry");
            // vm._refresh();
            // vm.setHttpRequestState(HttpRequestState.Ready);
            refreshController.requestRefresh();
          });
    });
  }
}

homeListItem(WendaDatas item, Function(WendaDatas) callback) {
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
                  "${item.superChapterName ?? ""}/${item.chapterName ?? ""}",
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
