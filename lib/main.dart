import 'package:flutter/material.dart';
import 'package:hacker_news/ui/home_page.dart';
import 'package:logging/logging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('hackernews-> ${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}
