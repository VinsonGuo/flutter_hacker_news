import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/model/model.dart';
import 'package:hacker_news/ui/base_list_page.dart';
import 'package:hacker_news/ui/widget/icon_text.dart';
import 'package:hacker_news/utils/api.dart';
import 'package:hacker_news/utils/routers.dart';

class HomePage extends StatelessWidget {
  final String title = 'HOME';

  final List<String> _tabTitles = [
    'NEWS',
    'BEST',
    'NEWEST',
    'SHOW',
    'ASK',
    'JOBS'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
            title: Text(title),
            bottom: TabBar(
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
              isScrollable: true,
            )),
        body: TabBarView(
            children: List.generate(
                _tabTitles.length, (index) => _HomeListPage(index))),
      ),
    );
  }
}
/*class HomePage extends StatelessWidget {
  final String title = 'HOME';

  final List<String> _tabTitles = [
    'NEWS',
    'BEST',
    'NEWEST',
    'SHOW',
    'ASK',
    'JOBS'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabTitles.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    title: Text(title),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      tabs:
                          _tabTitles.map((title) => Tab(text: title)).toList(),
                      isScrollable: true,
                    ))
              ];
            },
            body: TabBarView(
                children: List.generate(
                    _tabTitles.length, (index) => _HomeListPage(index))),
          )),
    );
  }
}*/

class _HomeListPage extends BaseListPage<Item> {
  final int _index;
  CancelToken _cancelToken;

  _HomeListPage(this._index);

  @override
  Widget buildItem(BuildContext context, Item item, int index) {
    return GestureDetector(
      key: Key(item.id.toString()),
      onTap: () {
        if (item.url != null) {
          Routers.toWebPage(context, item.url);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            // 分割线
            border: Border(
                bottom: BorderSide(
          width: 0.5,
          color: Theme.of(context).dividerColor,
        ))),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.timeAgo,
                  style: Theme.of(context).textTheme.caption,
                ),
                Container(
                  padding: EdgeInsets.only(top: 6, bottom: 6),
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                item.domain != null
                    ? Text(
                        item.domain,
                        style: Theme.of(context).textTheme.caption,
                      )
                    : Container()
              ],
            )),
            item.points == null
                ? Container()
                : IconText(
                    text: item.points.toString(),
                    iconData: Icons.whatshot,
                    color: Theme.of(context).primaryColor,
                  ),
            IconText(
              text: item.commentsCount.toString(),
              iconData: Icons.comment,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<List<Item>> loadData(int page) {
    _cancelToken = CancelToken();
    Future<List<Item>> future;
    switch (_index) {
      case 0:
        future = Api.getNews(page, token: _cancelToken);
        break;
      case 1:
        future = Api.getBest(page, token: _cancelToken);
        break;
      case 2:
        future = Api.getNewest(page, token: _cancelToken);
        break;
      case 3:
        future = Api.getShow(page, token: _cancelToken);
        break;
      case 4:
        future = Api.getAsk(page, token: _cancelToken);
        break;
      case 5:
        future = Api.getJobs(page, token: _cancelToken);
        break;
      default:
        future = Api.getNews(page, token: _cancelToken);
        break;
    }
    return future;
  }

  @override
  void dispose() {
    super.dispose();
    if (_cancelToken != null) {
      _cancelToken.cancel('cancel request');
    }
  }
}
