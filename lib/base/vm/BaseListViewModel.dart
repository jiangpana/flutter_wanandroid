

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'BaseViewModel.dart';

abstract class BaseListViewModel  extends BaseViewModel{
  BaseListViewModel();

  late var refreshController = RefreshController();

  var curPage = 0;

  int getNextPage() {
    return curPage++;
  }

  refresh() {
    curPage = 0;
  }



   request();


}