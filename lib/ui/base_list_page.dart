import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:logging/logging.dart';

abstract class BaseListPage<D> extends StatefulWidget {
  Future<List<D>> loadData(int page);

  Widget buildItem(BuildContext context, D item, int index);

  @override
  _BaseListState<D> createState() => _BaseListState<D>();
}

class _BaseListState<D> extends State<BaseListPage<D>> {
  static final Logger log = new Logger('_BaseListState');
  int _page = 1;
  final List<D> list = List();

  @override
  void initState() {
    super.initState();
    widget.loadData(_page).then((value) => setState(() => list.addAll(value)));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //下拉刷新
        _page = 1;
        final list = await widget.loadData(_page);
        this.list.clear();
        setState(() {
          this.list.addAll(list);
        });
      },
      child: LoadMore(
        child: ListView.builder(
          itemBuilder: (context, index) =>
              widget.buildItem(context, list[index], index),
          itemCount: list.length,
        ),
        onLoadMore: () async {
          // 加载更多
          var _list;
          try {
            _list = await widget.loadData(++_page);
          } catch (e) {
            log.severe('error', e);
            _page--;
            return false;
          }
          setState(() {
            this.list.addAll(_list);
          });
          return true;
        },
        whenEmptyLoad: false,
      ),
    );
  }
}
