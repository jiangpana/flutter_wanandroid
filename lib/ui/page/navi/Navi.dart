import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/base/BaseViewModel.dart';
import 'package:flutter_wanandroid/data/entity/navi_entity.dart';
import 'package:flutter_wanandroid/http/WanUrls.dart';

import '../../widget/Loading.dart';

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

class NaviViewModel extends BaseViewModel<NaviState> {
  NaviViewModel(super.state);

  void init() {
    var data = service.httpListGet<NaviEntity>(WanUrls.NAVI);
    data.then((value) {
      state = state.copyWith(naviData: value);
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

  late var vm = NaviViewModel(NaviState());

  late final navProvider =
      StateNotifierProvider<NaviViewModel, NaviState>((ref) => vm);

  @override
  void initState() {
    super.initState();
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, child) {
      var data = ref.watch(navProvider).naviData;
      if (data == null) {
        return Center(child :CommonLoading(),);
      }
      return ListView.builder(
          itemCount: data.length ?? 0,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        data![index].name!,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                    height: 2,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
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
                    (index2) => Card(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                          widthFactor: 1.1,
                          child: Text(data[index].articles![index2].title!)),
                    )),
                  ),
                )
              ],
            );
          });
    });
  }
}
