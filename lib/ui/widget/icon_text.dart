import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double padding;
  final Color color;

  IconText(
      {Key key,
      this.text,
      this.iconData,
      this.padding = 5,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          // 右边
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
}
