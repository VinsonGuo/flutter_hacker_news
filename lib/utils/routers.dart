import 'package:flutter/material.dart';
import 'package:hacker_news/ui/web_page.dart';

class Routers {
  static void toWebPage(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => WebPage(url)));
  }
}
