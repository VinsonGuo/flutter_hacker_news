import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {

  static void launch(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => WebPage(url)));
  }

  final String url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState(url);
}

class _WebPageState extends State<WebPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String _url;

  _WebPageState(this._url);

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      setState(() {
        _url = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) => WebviewScaffold(
        url: widget.url,
        appBar: AppBar(
          title: Text(_url),
        ),
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
//        initialChild: Container(
//          child: const Center(
//            child: CircularProgressIndicator(),
//          ),
//        ),
      );

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }
}
