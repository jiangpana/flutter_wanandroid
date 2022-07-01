import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wanandroid/ext/NavExt.dart';



//https://github.com/pichillilorenzo/flutter_inappwebview/issues/365

class Browser extends StatefulWidget {
   Browser(this.url,  this.title) : super();

  final String url;
 String title;

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {

  var jsCode="javascript:(function(){" +
      " console.log(document.documentElement.innerHTML);"+
      "var objs = document.getElementsByTagName(\"img\"); " +
      "for(var i=0;i<objs.length;i++)  " +
      "{"
      + "    objs[i].onclick=function()  " +
      "    {  "
      + "        window.flutter_inappwebview.callHandler('imageClick', this.src);  " +
      "    }  " +
      "}" +
      "})()";

  setTitle(title){
    setState(() {
      widget.title = title;
    });
  }
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
        resourceCustomSchemes: ["my-special-custom-scheme"]
    ),

    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );
  var urls =[];
  @override
  Widget build(BuildContext context) {
    late InAppWebViewController _controller;
    return WillPopScope(
        onWillPop: () async {
    /*      _controller.canGoBack().then((value) {
            if (value) {
              _controller.goBack();
            } else {
              return Navigator.pop(context);
            }
            ;
          });*/
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: InAppWebView(
            onLongPressHitTestResult:(controller,hitTestResult){

            } ,
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var url =navigationAction.request.url.toString();
              var urlScheme =navigationAction.request.url?.scheme.toString()??"";
              if(url.startsWith("https://app-wvhzpj.openinstall")){
                return NavigationActionPolicy.CANCEL;
              }
              if(url.startsWith("https://csdn-app.csdn.net/csdn.apk")){
                return NavigationActionPolicy.CANCEL;
              }
              if(url.startsWith("snssdk2606://")){
                return NavigationActionPolicy.CANCEL;
              }
              if(url.startsWith("https://z.juejin.cn/Ft2w?scheme=snssdk2606")){
                return NavigationActionPolicy.CANCEL;
              }
              if(url.startsWith("https://www.jianshu.com/apps")){
                return NavigationActionPolicy.CANCEL;
              }
              if(url.startsWith("https://downloads.jianshu")){
                return NavigationActionPolicy.CANCEL;
              }
              if(!urls.contains(url.toString())){
                urls.add(url.toString());
                if(urlScheme.startsWith("http") || urlScheme.startsWith("https")
                ){
                  print("url IsRedirect =${navigationAction.androidIsRedirect}");
                  if(navigationAction.androidIsRedirect == true){
                    controller.loadUrl(urlRequest: navigationAction.request);
                  }else{
                    navToPage(Browser(url, ""));
                    print("url navToPage  = $url");
                  }
                  urls.remove(url);
                }
              }
              return NavigationActionPolicy.CANCEL;
            },
            onWebViewCreated: (_controller1) {
              _controller = _controller1;
              _controller1
                .addJavaScriptHandler(
                    handlerName: "imageClick",
                    callback: (args) {
                      print("收到来自web的消息" + args.toString());
                    });

            },
            key: webViewKey,
            onLoadStop: (controller, url) async {
/*              await controller.evaluateJavascript(source: """
    const args = [1, true, ['bar', 5], {foo: 'baz'}];
    window.flutter_inappwebview.callHandler('imageClick', ...args);
  """);
              await controller.evaluateJavascript(source:"console.log(document.documentElement.innerHTML);");
              await controller.evaluateJavascript(source:jsCode );*/
            },
              onTitleChanged:(controller,title){
              setTitle(title);
              }
            ,
            onLoadResourceCustomScheme: (InAppWebViewController controller, url) async {
              if (url.scheme == "my-special-custom-scheme") {
                var bytes = await rootBundle.load("test_assets/${url.toString().replaceFirst("my-special-custom-scheme://", "", 0)}");
                var response = CustomSchemeResponse(data: bytes.buffer.asUint8List(), contentType: "image/svg+xml");
                return response;
              }
              return null;
            },
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            initialOptions: options,
          ),
        ));
  }
}
