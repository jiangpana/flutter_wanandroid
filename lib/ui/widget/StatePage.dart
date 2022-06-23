import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/base/state/BaseState.dart';

import '../../ext/NetStateExt.dart';
import 'Loading.dart';

Widget statePage(
    {required Widget child, required HttpRequestState state, Function? retry}) {
  switch (state) {
    case HttpRequestState.Ready:
      return Center(child: Text(""));
    case HttpRequestState.Loading:
      return Center(child: CommonLoading());
    case HttpRequestState.Suc:
      return child;
    case HttpRequestState.Fail:
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

Widget refreshListStatePage(
    {required Widget child, required bool fail, Function? retry}) {
  var items = [child];
  if (fail) {
    items.add(Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.near_me_disabled),
          TextButton(
              onPressed: () {
                retry?.call();
              },
              child: Text("加载出错 , 点击重试 "))
        ],
      ),
    ));
  }
  return Stack(
    children: items,
  );
}
