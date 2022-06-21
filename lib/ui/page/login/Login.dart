import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/data/entity/user_entity.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';
import 'package:flutter_wanandroid/http/WanUrls.dart';

import '../../../base/BaseState.dart';
import '../../../base/BaseViewModel.dart';
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

class LoginViewModel extends BaseViewModel<LoginPageState> {
  LoginViewModel({state})
      : super(state ?? LoginPageState(user: '', pwd: '', rep: ''));



  _register() async {
    var rep =
        await service.httpPost<UserEntity>(WanUrls.REGISTER, queryParameters: {
      "username": state.user,
      "password": state.pwd,
      "repassword": state.pwd,
    });
    state = state.copyWith(rep: rep.toString() + "222");
  }

  _login() async {
    var rep =
        await service.httpPost<UserEntity>(WanUrls.LOGIN, queryParameters: {
      // "username": state.user,
      "username": "11111111111y放1",
      // "password": state.pwd,
      "password": "eeeeeee",
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
  late final loginProvider =
      StateNotifierProvider<LoginViewModel, LoginPageState>((ref) => vm);

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
      var httpState = vm.getHttpState(ref).state;
      var message = vm.getHttpState(ref).message;
      print("httpState = $httpState");
      print("message = $message");
      var state = ref.watch(loginProvider);
      return Scaffold(
          appBar: AppBar(
            title: Text("登录/注册"),
          ),
          body: LoginContent(httpState, state, vm,message));
    });
  }
}

LoginContent(
    HttpRequestState httpState, LoginPageState state, LoginViewModel vm,String? message) {
  Widget hint = Text(
    message??"",
    style: TextStyle(color: Colors.red),
  );
  if (httpState == HttpRequestState.Loading) {
    hint = CircularProgressIndicator();
  }
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text :"11111111111y放1"),
              onChanged: (user) {
                print(user);
                state.user = user;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: TextEditingController(text :"eeeeeee"),
              onChanged: (pwd) {
                state.pwd = pwd;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      vm._register();
                    },
                    child: Text("注册")),
                TextButton(
                    onPressed: () {
                      vm._login();
                    },
                    child: Text("登录"))
              ],
            ),
            hint
          ],
        ),
      )
    ],
  );
}
