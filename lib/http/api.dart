import 'package:dio/dio.dart';
import 'package:hacker_news/model/model.dart';
import 'package:logging/logging.dart';

class Api {
  static Dio _instance;
  static final Logger log = new Logger('http');

  static Dio _getInstance() {
    if (_instance == null) {
      // 或者通过传递一个 `options`来创建dio实例
      Options options = new Options(
          baseUrl: 'http://api.hackerwebapp.com',
          connectTimeout: 5000,
          receiveTimeout: 3000);
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

  static Future<List<Item>> _getItems(String path, int page,
      {CancelToken token}) async {
    final response = await _getInstance()
        .get("/$path", data: {'page': page}, cancelToken: token);
    List<Item> list =
        (response.data as List).map((item) => Item.fromJson(item)).toList();
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
