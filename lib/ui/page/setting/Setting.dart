


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ui/widget/CityChoose.dart';

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
    rootBundle.loadString("assets/city.json").then((value) {
      var data =<String>[];
      var jsonCity=json.decode(value );
      var list =jsonCity["city"] as List<dynamic>;
      for (var element in list) {
        var obj =element as Map<String, dynamic>;
        data.add(obj["title"]);
        data.addAll((obj["lists"] as List<dynamic>).map((e) => e.toString()));
      }

      setState((){
        this.data.addAll(data);
      });

    });
  }

  var data=<String>[];
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
      // var data = vm.settingPageNotifier.watch(ref);
      return CityChoose(data);
    });
  }
}
