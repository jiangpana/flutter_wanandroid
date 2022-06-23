import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../data/WanRepository.dart';
import '../../../data/db/table/Article.dart';
import '../../../ext/NavExt.dart';
import '../../widget/Browser.dart';
import '../../widget/ListItem.dart';

class HistoryState {
  var datas = <Article>[];

  HistoryState.initial() : datas = <Article>[];

  HistoryState({required this.datas});

  HistoryState copyWith({
    datas,
  }) {
    return HistoryState(
      datas: datas ?? this.datas,
    );
  }
}

class HistoryViewModel extends BaseViewModel {
  late final qaPageNotifier = newNotifier(HistoryState.initial());

  HistoryState get _qaState => qaPageNotifier.state;

  set _qaState(HistoryState state) {
    qaPageNotifier.state = state;
  }

  init() async {
    WanRepository().db.articleTable.getAll().then((value) {
      _qaState = _qaState.copyWith(datas: value);
    });
  }
}

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var vm = HistoryViewModel();

  @override
  void initState() {
    super.initState();
    // 初始化
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("历史记录"),
        ),
        body: Consumer(builder: (context, ref, _) {
          var data = vm.qaPageNotifier.watch(ref).datas;
          return ListView.builder(
            itemBuilder: (c, index) {
              final entity = data[index];
              return commonListItem(
                  id: entity.id,
                  title: entity.title,
                  shareUser: entity.shareUser,
                  chapterName: entity.chapterName,
                  niceDate: entity.niceDate,
                  link: entity.link,
                  itemClick: () {
                    navToPage(Browser(entity.link!, entity.title!));
                  });
            },
            itemCount: data.length,
          );
        }));
  }
}
