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
  static void launch(BuildContext context, int id, String url) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => ArticleDetailPage(id, url)));
  }

  final String url;
  final int id;

  ArticleDetailPage(this.id, this.url);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  ArticleDetail _detail;
  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    Api.getArticleDetail(widget.url, _cancelToken).then((detail) {
      setState(() {
        _detail = detail;
      });
    }).catchError((e) {
      log.severe("getArticleDetail", e);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_detail?.title ?? 'Loading...'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: () => WebPage.launch(
                  context, '${Api.hackerNewsUrl}item?id=${widget.id}'),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(widget.url),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ArticleDetail detail =
                await Api.getArticleDetail(widget.url, _cancelToken);
            setState(() {
              _detail = detail;
            });
          },
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}
