import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Browser extends StatefulWidget {
  const Browser(this.url, this.title) : super();

  final String url;
  final String title;

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
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
    late InAppWebViewController _controller ;
    return WillPopScope(
        onWillPop: ()async {
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
        onWebViewCreated: (_controller1) {
          _controller=_controller1;
        },
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        initialOptions: options,
      ),
    ));

  }
}
