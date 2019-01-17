import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/model/model.dart';
import 'package:hacker_news/utils/api.dart';
import 'package:logging/logging.dart';

final Logger log = new Logger('ArticleDetailPage');

class ArticleDetailPage extends StatefulWidget {
  static void launch(BuildContext context, String url) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ArticleDetailPage(url)));
  }

  final String url;

  ArticleDetailPage(this.url);

  @override
  _ArticleDetailState createState() => _ArticleDetailState(url);
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  String _url;
  ArticleDetail _detail;

  _ArticleDetailState(this._url);

  @override
  void initState() {
    super.initState();
    Api.getArticleDetail(_url).then((detail) {
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
            ArticleDetail detail = await Api.getArticleDetail(_url);
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
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Center(
                    child: _detail == null
                        ? CircularProgressIndicator()
                        : Html(
                            data: _detail.content,
                          ),
                  );
                }, childCount: 1),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
