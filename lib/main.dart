import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ui/page/home/Home.dart';
import 'package:flutter_wanandroid/ui/page/mine/Mine.dart';
import 'package:flutter_wanandroid/ui/page/navi/Navi.dart';
import 'package:flutter_wanandroid/ui/page/qa/Qa.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'data/http/CookieManager.dart';

final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();
late BuildContext sContext;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  readRunApp();
}

void readRunApp() async {
  try {
    //设置高刷模式
    await FlutterDisplayMode.setHighRefreshRate();
  } on Exception catch (e) {}
  await CookieManager.instance.initCookie();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("main build");
    return RefreshConfiguration(
        hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
        child: MaterialApp(
          navigatorObservers: [routeObserver],
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        ));
  }
}

late var mainPages = <Widget>[
  HomeArListPage(),
  QaPage(),
  NaviPage(),
  MinePage()
];

late var navData = [
  {"首页", Icon(Icons.home)},
  {"每日一问", Icon(Icons.question_mark)},
  {"导航", Icon(Icons.low_priority)},
  {"我的", Icon(Icons.person)},
];

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    sContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("WanAndroid"),
      ),
      body: PageView.builder(
        itemBuilder: (ctx, index) => mainPages[index],
        itemCount: mainPages.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, watch, _) {
        return BottomNavigationBar(
          items: List.generate(navData.length, (index) {
            return BottomNavigationBarItem(
              icon: navData[index].last as Icon,
              label: navData[index].first as String,
            );
          }),
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Theme.of(context).primaryColor,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        );
      }),
    );
  }
}

/*
    floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
*/




//flutter pub run build_runner build