import 'package:dio/dio.dart';
import 'package:hacker_news/model/model.dart';
import 'package:logging/logging.dart';

class Api {
  static final String hackerNewsUrl = 'https://news.ycombinator.com/';
  static final String mercuryKey = 'Duud5bHkiTnSlTlaC2SLU3kZQjmiUEMkwofpyW7O';
  static final String mercuryUrl = 'https://mercury.postlight.com/parser';
  static Dio _instance;
  static final Logger log = new Logger('http');

  static Dio _getInstance() {
    if (_instance == null) {
      // 或者通过传递一个 `options`来创建dio实例
      Options options = new Options(connectTimeout: 5000, receiveTimeout: 3000);
      _instance = Dio(options);
      _instance.interceptor.request.onSend = (options) {
        log.fine(
            'url: ${options.baseUrl}${options.path}   data: ${options.data}');
        return options;
      };
      _instance.interceptor.response.onSuccess = (Response response) {
        log.fine('response: ${response.data}');
        return response; // continue
      };
      _instance.interceptor.response.onError = (DioError e) {
        log.severe('error', e);
        return e; //continue
      };
    }
    return _instance;
  }

  static Future<ArticleDetail> getArticleDetail(String url,
      {CancelToken token}) async {
    final response = await _getInstance().get(mercuryUrl,
        data: {'url': url},
        options: Options(headers: {'x-api-key': mercuryKey}),
        cancelToken: token);
    ArticleDetail detail = ArticleDetail.fromJson(response.data);
    return Future.value(detail);
  }

  static Future<List<Item>> _getItems(String path, int page,
      {CancelToken token}) async {
    final response = await _getInstance().get(
        "http://api.hackerwebapp.com/$path",
        data: {'page': page},
        cancelToken: token);
    List<Item> list = (response.data as List).map((item) {
      final i = Item.fromJson(item);
      if (i.url != null && !i.url.startsWith('http')) {
        i.url = hackerNewsUrl + i.url;
      }
      return i;
    }).toList();
    return Future.value(list);
  }

  static Future<List<Item>> getNews(int page, {CancelToken token}) async {
    return _getItems('news', page, token: token);
  }

  static Future<List<Item>> getNewest(int page, {CancelToken token}) async {
    return _getItems('newest', page, token: token);
  }

  static Future<List<Item>> getBest(int page, {CancelToken token}) async {
    return _getItems('best', page, token: token);
  }

  static Future<List<Item>> getAsk(int page, {CancelToken token}) async {
    return _getItems('ask', page, token: token);
  }

  static Future<List<Item>> getShow(int page, {CancelToken token}) async {
    return _getItems('show', page, token: token);
  }

  static Future<List<Item>> getJobs(int page, {CancelToken token}) async {
    return _getItems('jobs', page, token: token);
  }
}
