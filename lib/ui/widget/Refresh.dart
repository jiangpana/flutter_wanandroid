import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Loading.dart';

class RefreshList extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget? content;

  RefreshList(
      {required this.controller,
      required this.onRefresh,
      required this.onLoading,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      enableLoadingWhenNoData: true,
      enableLoadingWhenFailed: true,
      footerTriggerDistance: 0,
      enableBallisticLoad: true,
      maxUnderScrollExtent: 0,
      child: ScrollConfiguration(
        behavior: MaterialScrollBehavior(),
        child: SmartRefresher(
          controller: this.controller,
          enablePullDown: true,
          enablePullUp: true,
          header: CustomHeader(
            builder: (BuildContext context, RefreshStatus? mode) {
              Widget? body = CommonLoading();
              if (mode == RefreshStatus.failed) {
                body = _loadFailed();
              }
              /*        if (mode == RefreshStatus.canRefresh) {
                  body = textIndicator("松开刷新");
                } else if (mode == RefreshStatus.refreshing) {
                  body = textIndicator("加载中...");
                } else if (mode == RefreshStatus.idle) {
                  body = textIndicator("下拉刷新");
                } else if (mode == RefreshStatus.completed) {
                  body = textIndicator("加载成功");
                }*/
              return Container(
                padding: EdgeInsets.only(top: 6),
                height: 76,
                child: Center(
                  child: body,
                ),
              );
            },
          ),
          footer: CustomFooter(
            loadStyle: LoadStyle.HideAlways,
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载", style: TextStyle(fontSize: 12));
              } else if (mode == LoadStatus.loading) {
                body = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                          strokeWidth: 1.6,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text("加载中...", style: TextStyle(fontSize: 12))
                    ],
                  ),
                );
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败！点击重试！", style: TextStyle(fontSize: 12));
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手,加载更多!", style: TextStyle(fontSize: 12));
              } else {
                body = Text("没有更多数据了!", style: TextStyle(fontSize: 12));
              }
              return Container(
                height: 55.0,
                child: Center(child: null),
              );
            },
          ),
          onRefresh: this.onRefresh,
          onLoading: this.onLoading,
          child: this.content,
        ),
      ),
    );
  }

  Widget _loadFailed() {
    return Center(
      child: Text("加载失败", style: TextStyle(color: Colors.red)),
    );
  }

/*  Widget textIndicator(String statusStr) {
    return Container(
      child: Stack(
        children: [
          Lottie.asset(
            'assets/loading.json',
            width: 100,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }*/
}
