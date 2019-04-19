import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/model/model.dart';
import 'package:hacker_news/ui/web_page.dart';
import 'package:hacker_news/utils/api.dart';
import 'package:logging/logging.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Logger log = new Logger('ArticleDetailPage');

class ArticleDetailPage extends StatefulWidget {
  static void launch(BuildContext context, Item item) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => ArticleDetailPage(item)));
  }

  final Item item;

  ArticleDetailPage(this.item);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  CancelToken _cancelToken = CancelToken();
  WebViewController _webViewController;
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.item.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: () => WebPage.launch(
                  context, '${Api.hackerNewsUrl}item?id=${widget.item.id}'),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(widget.item.url),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.item.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) => _webViewController = controller,
              onPageFinished: (url) =>
                  this.setState(() => _showProgress = false),
            ),
            Visibility(
              child: Center(child: CircularProgressIndicator()),
              visible: _showProgress,
            )
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}
