import 'package:flutter/material.dart';
import 'package:hacker_news/http/api.dart';
import 'package:hacker_news/model/model.dart';
import 'package:hacker_news/ui/base_list_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

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
                  _tabTitles.length, (index) => HomeListPage(index)))),
    );
  }
}

class HomeListPage extends BaseListPage<Item> {
  final int _index;

  HomeListPage(this._index);

  @override
  Widget buildItem(BuildContext context, Item item, int index) {
    return ListTile(key: Key(item.id.toString()), title: Text(item.title));
  }

  @override
  Future<List<Item>> loadData(int page) {
    Future<List<Item>> future;
    switch (_index) {
      case 0:
        future = Api.getNews(page);
        break;
      case 1:
        future = Api.getBest(page);
        break;
      case 2:
        future = Api.getNewest(page);
        break;
      case 3:
        future = Api.getShow(page);
        break;
      case 4:
        future = Api.getAsk(page);
        break;
      case 5:
        future = Api.getJobs(page);
        break;
      default:
        future = Api.getNews(page);
        break;
    }
    return future;
  }
}
