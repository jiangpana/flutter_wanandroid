


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/vm/BaseViewModel.dart';

class SettingState{
  SettingState. initial() {}

}
class SettingViewModel extends BaseViewModel {

  late final settingPageNotifier = newNotifier(SettingState.initial());

  SettingState get _qaState => settingPageNotifier.state;

  set _qaState(SettingState state) {
    settingPageNotifier.state = state;
  }

  void init() {

  }


}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var vm = SettingViewModel();

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
          title: const Text("设置"),
        ),
        body: _settingPageContent() );
  }

  Widget _settingPageContent() {
   return Consumer(builder: (context, ref, _) {
      var data = vm.settingPageNotifier.watch(ref);
      return Text("待开发");
    });
  }
}
