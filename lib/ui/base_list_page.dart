import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:logging/logging.dart';

abstract class BaseListPage<D> extends StatefulWidget {
  Future<List<D>> loadData(int page);

  Widget buildItem(BuildContext context, D item, int index);

  void dispose() {}

  @override
  _BaseListState<D> createState() => _BaseListState<D>();
}

class _BaseListState<D> extends State<BaseListPage<D>>
    with AutomaticKeepAliveClientMixin {
  static final Logger log = new Logger('_BaseListState');
  int _page = 1;
  List<D> list = List();
  bool isLoadMoreFinish = false;
  bool isShowProgress = true;

  @override
  void initState() {
    super.initState();
    widget
        .loadData(_page)
        .then((value) => setState(() {
              isShowProgress = false;
              isLoadMoreFinish = false;
              list += value;
            }))
        .catchError((e) => log.severe("e", e));
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        children: [
          isShowProgress
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    //下拉刷新
                    _page = 1;
                    final list = await widget.loadData(_page);
                    this.list.clear();
                    setState(() {
                      isShowProgress = false;
                      isLoadMoreFinish = false;
                      this.list += list;
                    });
                  },
                  child: LoadMore(
                    isFinish: isLoadMoreFinish,
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          widget.buildItem(context, list[index], index),
                      itemCount: list.length,
                    ),
                    onLoadMore: () async {
                      // 加载更多
                      List<D> _list;
                      try {
                        _list = await widget.loadData(++_page);
                        if (_list == null || _list.isEmpty) {
                          setState(() {
                            isShowProgress = false;
                            isLoadMoreFinish = true;
                          });
                        }
                      } catch (e) {
                        log.severe('error', e);
                        _page--;
                        return false;
                      }
                      setState(() {
                        isShowProgress = false;
                        this.list += _list;
                      });
                      return true;
                    },
                    whenEmptyLoad: false,
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
