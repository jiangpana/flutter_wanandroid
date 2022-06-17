

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/base/BaseViewModel.dart';

class QaState {
  QaState({this.QaData});

  List<String>? QaData;

  QaState copyWith({
    QaData,
  }) {
    return QaState(
      QaData: QaData ,
    );
  }
}

class QaViewModel extends BaseViewModel<QaState> {
  QaViewModel(super.state);
}
class QaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_QaPageState();
}
class _QaPageState extends State<QaPage>
    with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  late var vm = QaViewModel(QaState());

  late final homeProvider =
  StateNotifierProvider<QaViewModel, QaState>((ref) => vm);

  @override
  Widget build(BuildContext context) {

    return Consumer(builder: (_,ref,child){

      return Text("");
    });
  }
}