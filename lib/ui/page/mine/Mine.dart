import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:flutter_wanandroid/ui/page/collect/Collect.dart';
import 'package:flutter_wanandroid/ui/page/login/Login.dart';

import '../../../base/vm/BaseViewModel.dart';
import '../../../data/entity/navi_entity.dart';
import '../../../data/entity/user_entity.dart';
import '../../../ext/EventBusExt.dart';
import '../../../ext/ToastExt.dart';
import '../../../http/WanUrls.dart';
import '../../widget/Dialog.dart';

const String LOGIN_RESULT_SUC = "login_result_suc";

class MineState {
  MineState({this.user});

  UserEntity? user;

  MineState copyWith({
    user,
  }) {
    return MineState(
      user: user,
    );
  }
}

class MineViewModel extends BaseViewModel {
  late final minePageNotifier = newNotifier(MineState());

  MineState get _minePageState => minePageNotifier.state;

  set _minePageState(MineState state) {
    minePageNotifier.state = state;
  }

  // 注册监听器，订阅 eventbus
  late final _onLogin = eventBus.on<EventFn>().listen((event) {
    var data = event.obj as Map<String, dynamic>;
    if (data[LOGIN_RESULT_SUC] != null) {
      var entity = data[LOGIN_RESULT_SUC] as UserEntity;
      _minePageState = _minePageState.copyWith(user: entity);
    }
  });

  init() {
    _onLogin.resume();
    repository.get<UserEntity>(WanUrls.LOGIN).then((value) {
      if (value != null) {
        _minePageState =  _minePageState.copyWith(user: value);
      }
    });
  }

  void _login() {
    navToPage(LoginPage());
  }

  Function? onLogout;

  void _logout() async {
    await service.httpGet(WanUrls.LOGOUT);
    onLogout?.call();
    _minePageState = _minePageState.copyWith(user: null);
    repository.remove(WanUrls.LOGIN);
  }

  void showDialog() {
    showCenterDialog(
        content: "确定退出登录?",
        ok: () {
          _logout();
        });
  }

  void dispose() {
    _onLogin.cancel();
  }
}

class MinePage extends StatefulWidget {
  MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late var vm = MineViewModel();
  static const String COLLECT = "收藏";
  static const String SETTING = "设置";
  static const String LOG_OUT = "退出登录";
  late var items = [
    {SETTING, Icon(Icons.settings)},
  ];
  late var loginItems = [
    {COLLECT, Icon(Icons.favorite)},
    {LOG_OUT, Icon(Icons.logout)},
  ];

  @override
  void initState() {
    super.initState();
    vm.init();
    vm.onLogout = () {};
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    vm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var data = vm.minePageNotifier.watch(ref);
      return _mineContent(data);
    });
  }

   _mineContent(MineState data) {
    var title = items.last.elementAt(0) as String;
    if (data.user != null) {
      if (title != LOG_OUT) {
        items.addAll(loginItems);
      }
    } else {
      if (title == LOG_OUT) {
        items.removeRange(items.length - loginItems.length, items.length);
      }
    }
    return CustomScrollView(
        reverse: false,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.blue,
            expandedHeight: 200.0,
            iconTheme: IconThemeData(color: Colors.transparent),
            flexibleSpace: InkWell(
                onTap: () {
                  data.user == null ? vm._login() : debugPrint('用户信息');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        data.user == null ? '点击头像登录' : data.user!.nickname!,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )
                  ],
                )),
          ),
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                String title = items[index].elementAt(0) as String;
                Icon icon = items[index].elementAt(1) as Icon;
                return Container(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        _onItemClick(title);
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 10,
                                ),
                                icon,
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  title,
                                  style: TextStyle(),
                                )),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            height: 2,
                          )
                        ],
                      ),
                    ));
              }, childCount: items.length),
              itemExtent: 60),
        ]);
  }

  void _onItemClick(String title) {
    if (title == LOG_OUT) {
      vm.showDialog();
    }
    if (title == SETTING) {
      showToast("SETTING");
    }
    if (title == COLLECT) {
      navToPage(CollectPage());
    }
  }
}


/*           data.user == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 60,
                        )
                      : Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: NetworkImage(data.userAvatar!),
                                  fit: BoxFit.cover),
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                        )*/