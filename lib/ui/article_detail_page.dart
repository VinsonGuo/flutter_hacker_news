import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hacker_news/model/model.dart';
import 'package:hacker_news/utils/api.dart';
import 'package:html/dom.dart' hide Text;
import 'package:logging/logging.dart';
import 'package:share/share.dart';

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
        body: RefreshIndicator(
          onRefresh: () async {
            ArticleDetail detail =
                await Api.getArticleDetail(widget.url, _cancelToken);
            setState(() {
              _detail = detail;
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(_detail?.title ?? 'Loading'),
                pinned: true,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                    background: _detail?.leadImageUrl == null
                        ? Icon(Icons.panorama)
                        : Image.network(
                            _detail.leadImageUrl,
                            fit: BoxFit.cover,
                          )),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add_comment),
                    onPressed: () => FlutterWebBrowser.openWebPage(
                        url: '${Api.hackerNewsUrl}item?id=${widget.id}',
                        androidToolbarColor: Theme.of(context).primaryColor),
                  ),
                  IconButton(
                    icon: Icon(Icons.web),
                    onPressed: () => FlutterWebBrowser.openWebPage(
                        url: widget.url,
                        androidToolbarColor: Theme.of(context).primaryColor),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () => Share.share(widget.url),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(children: [
                  Padding(
                    child: Text(
                      _detail?.title ?? '',
                      style: Theme.of(context).textTheme.title,
                    ),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 20),
                  ),
                  _detail == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Html(
                          data: _detail.content,
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          onLinkTap: (url) => FlutterWebBrowser.openWebPage(
                              url: url,
                              androidToolbarColor:
                                  Theme.of(context).primaryColor),
                        ),
                ]),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }

}
