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

  static Future<List<Item>> _getItems(String path, int page) async {
    final response = await _getInstance().get("/$path", data: {'page': page});
    List<Item> list =
        (response.data as List).map((item) => Item.fromJson(item)).toList();
    return Future.value(list);
  }

  static Future<List<Item>> getNews(int page) async {
    return _getItems('news', page);
  }

  static Future<List<Item>> getNewest(int page) async {
    return _getItems('newest', page);
  }

  static Future<List<Item>> getBest(int page) async {
    return _getItems('best', page);
  }

  static Future<List<Item>> getAsk(int page) async {
    return _getItems('ask', page);
  }

  static Future<List<Item>> getShow(int page) async {
    return _getItems('show', page);
  }

  static Future<List<Item>> getJobs(int page) async {
    return _getItems('jobs', page);
  }
}
