import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:flutter_wanandroid/ui/page/home/state/HomePageState.dart';
import 'package:flutter_wanandroid/ui/widget/StatePage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../data/entity/article_list_entity.dart';
import '../../../data/http/WanUrls.dart';
import '../../widget/Browser.dart';
import '../../widget/ListItem.dart';
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

  showFailedPage() {return httpState.isFail()&&_homeState.datas.isEmpty ;}

  int _getNextPage() {
    return _homeState.articleListEntity?.curPage ?? 0;
  }

  _refresh() {
    _homeState.articleListEntity?.curPage = 0;
  }

  _request() async {
    var value = await service.getArticleList(page:_getNextPage());
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
          fail:  vm.showFailedPage(),
          retry: () {
            vm.retry();
          });
    });
  }
}
