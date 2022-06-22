import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/base/BaseState.dart';

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


Widget refreshListStatePage(
    {required Widget child, required bool fail, Function? retry}) {
  var items = [child];
/*  if (fail) {
    items.add(Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color:Colors.red ,shape:BoxShape.circle),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_adult_content,color: Colors.white,),
            TextButton(
                onPressed: () {
                  retry?.call();
                },
                child: Text("刷新 ",style:TextStyle(color: Colors.white) ))
          ],
        ),
      ),
    ));
  }*/
  return Stack(
    children: items,
  );
}
