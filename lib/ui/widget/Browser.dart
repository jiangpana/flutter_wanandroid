import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wanandroid/ext/ToastExt.dart';



//https://github.com/pichillilorenzo/flutter_inappwebview/issues/365

class Browser extends StatefulWidget {
  const Browser(this.url, this.title) : super();

  final String url;
  final String title;

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

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController _controller;
    return WillPopScope(
        onWillPop: () async {
          _controller.canGoBack().then((value) {
            if (value) {
              _controller.goBack();
            } else {
              return Navigator.pop(context);
            }
            ;
          });

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: InAppWebView(
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              controller.loadUrl(urlRequest: navigationAction.request);
              return null;
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
              await controller.evaluateJavascript(source: """      
    const args = [1, true, ['bar', 5], {foo: 'baz'}];
    window.flutter_inappwebview.callHandler('imageClick', ...args);
  """);
              await controller.evaluateJavascript(source:"console.log(document.documentElement.innerHTML);");
              await controller.evaluateJavascript(source:jsCode );
            },
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
