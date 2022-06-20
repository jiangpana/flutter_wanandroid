import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/base/BaseState.dart';

import 'Loading.dart';

Widget statePage(
    {required Widget child, required HttpRequestState state, Function? retry}) {
  switch (state) {
    case HttpRequestState.Ready:
      return Center(child: Text(""));
    case HttpRequestState.No_Data:
      return Center(
        child: Text("暂无数据"),
      );
    case HttpRequestState.Loading:
      return Center(child: CommonLoading());
    case HttpRequestState.Suc:
      return child;
    case HttpRequestState.Fail:
      return Center(
        child: Column(mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Icon(Icons.near_me_disabled),
            TextButton(
                onPressed: () {
                  retry?.call();
                },
                child: Text("加载出错 , 点击重试 "))
          ],
        ),
      );
  }
}


/*

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
                itemBuilder: (c, index) => homeListItem(data[index], (item) {
                  navToPage(Browser(item.link!, item.title!));
                }),
                itemExtent: 100.0,
                itemCount: data.length,
              )),
          state: httpState,
          retry: () {
            print("retry");
            // vm._refresh();
            // vm.setHttpRequestState(HttpRequestState.Ready);
            refreshController.requestRefresh();
          });

*/
Widget refreshListStatePage(
    {required Widget child, required bool empty, Function? retry}) {
  var items = [child];
  if (empty) {
    items.add(Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_adult_content,color: Colors.black,),
            TextButton(
                onPressed: () {
                  retry?.call();
                },
                child: Text("没有数据 , 点击刷新 ",style:TextStyle(color: Colors.black) ))
          ],
        ),
      ),
    ));
  }
  return Stack(
    children: items,
  );
}
