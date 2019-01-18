import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double padding;
  final Color color;
  final GestureTapCallback onTap;

  IconText(
      {Key key,
      this.text,
      this.iconData,
      this.onTap,
      this.padding = 5,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
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
        ),
      );
}
