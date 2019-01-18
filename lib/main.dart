import 'package:flutter/material.dart';
import 'package:hacker_news/ui/home_page.dart';
import 'package:logging/logging.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

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
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primarySwatch: Colors.deepOrange,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Hacker News',
            theme: theme,
            home: new HomePage(),
          );
        }
    );
  }
}
