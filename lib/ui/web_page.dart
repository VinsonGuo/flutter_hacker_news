import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  static void launch(BuildContext context, String url) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => WebPage(url)));
  }

  final String url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState(url);
}

class _WebPageState extends State<WebPage> {
  WebViewController _controller;
  String _url;

  _WebPageState(this._url);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_url),
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          onPageFinished: (url) {},
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
