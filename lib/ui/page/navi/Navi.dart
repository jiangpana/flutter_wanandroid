import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/base/vm/BaseViewModel.dart';
import 'package:flutter_wanandroid/data/entity/navi_entity.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';

import '../../widget/Browser.dart';
import '../../widget/StatePage.dart';

class NaviState {
  NaviState({this.naviData});

  List<NaviEntity>? naviData;

  NaviState copyWith({
    naviData,
  }) {
    return NaviState(
      naviData: naviData,
    );
  }
}

class NaviViewModel extends BaseViewModel {

  late final naviPageNotifier = newNotifier(NaviState());

  NaviState get _minePageState => naviPageNotifier.state;

  set _minePageState(NaviState state) {
    naviPageNotifier.state = state;
  }

  void init() async {
    service.getNavi().then((value) {
      print("service.getNavi() = ${value![0]}");
      _minePageState = _minePageState.copyWith(naviData: value);
    });
  }
}

class NaviPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var vm = NaviViewModel();

  @override
  void initState() {
    super.initState();
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, child) {
      var data = vm.naviPageNotifier.watch(ref).naviData;
      var httpState = vm.watchHttpState(ref).state;
      return statePage(
          child: ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                return _naviListItem(data!, index);
              }),
          state: httpState,
          retry: () {
            vm.init();
          });
    });
  }

  _naviListItem(List<NaviEntity> data, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              data[index].name!,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
            height: 2,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue,
                Color.fromRGBO(174, 206, 250, 1.0),
              ],
            ))),
        Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          children: List.generate(
            data[index].articles?.length ?? 0,
            (index2) => InkWell(
                onTap: () {
                  var item = data[index].articles![index2];
                  navToPage(Browser(item.link!, item.title!));
                },
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                      widthFactor: 1.1,
                      child: Text(data[index].articles![index2].title!)),
                ))),
          ),
        )
      ],
    );
  }
}
