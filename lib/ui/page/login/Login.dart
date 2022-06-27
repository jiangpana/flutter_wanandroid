import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/data/entity/user_entity.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';

import '../../../base/state/BaseState.dart';
import '../../../base/vm/BaseViewModel.dart';
import '../../../data/http/WanUrls.dart';
import '../../../ext/EventBusExt.dart';
import '../../../main.dart';
import '../mine/Mine.dart';

class LoginPageState {
  var user = "";
  var pwd = "";
  var rep = "";

  LoginPageState({required this.user, required this.pwd, required this.rep});

  LoginPageState copyWith({
    user,
    pwd,
    rep,
  }) {
    return LoginPageState(
      user: user ?? this.user,
      pwd: pwd ?? this.pwd,
      rep: rep ?? this.rep,
    );
  }
}

class LoginViewModel extends BaseViewModel {
  late final loginPageNotifier =
      newNotifier(LoginPageState(user: '', pwd: '', rep: ''));

  LoginPageState get _loginPageState => loginPageNotifier.state;

  set _loginPageState(LoginPageState state) {
    loginPageNotifier.state = state;
  }

  register() async {
    var rep =
        await service.httpPost<UserEntity>(WanUrls.REGISTER, queryParameters: {
      "username": _loginPageState.user,
      "password": _loginPageState.pwd,
      "repassword": _loginPageState.pwd,
    });
    _loginPageState = _loginPageState.copyWith(rep: rep.toString());
  }

  login() async {
    var rep =
        await service.httpPost<UserEntity>(WanUrls.LOGIN, queryParameters: {
      "username": _loginPageState.user,
      "password": _loginPageState.pwd,
    });
    if (rep != null) {
      eventBus.fire(EventFn({
        LOGIN_RESULT_SUC: rep,
      }));
      finish();
    }
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with RouteAware {
  late LoginViewModel vm = LoginViewModel();

  @override
  void didPopNext() {
    print("didPopNext");
  }

  @override
  void didPushNext() {
    print("didPushNext");
  }

  @override
  void didPop() {
    print("didPop");
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!); //订阅
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }

  @override
  void didPush() {
    print("didPush");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("登录/注册"),
          ),
          body: _loginContent(vm, ref));
    });
  }

  _loginContent(LoginViewModel vm, WidgetRef ref) {

    var state = vm.loginPageNotifier.watch(ref);
    var httpState = vm.watchHttpState(ref).state;
    var message = vm.watchHttpState(ref).message;
    Widget hint = Text(
      message ?? "",
      style: const TextStyle(color: Colors.red),
    );
    if (httpState == HttpRequestState.Loading) {
      hint = const CircularProgressIndicator();
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                onChanged: (user) {
                  state.user = user;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                ),
              ),
              TextField(
                onChanged: (pwd) {
                  state.pwd = pwd;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                ),
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        vm.register();
                      },
                      child: const Text("注册")),
                  TextButton(
                      onPressed: () {
                        vm.login();
                      },
                      child: const Text("登录"))
                ],
              ),
              hint
            ],
          ),
        )
      ],
    );
  }
}
