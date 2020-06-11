import 'package:flutter/material.dart';
import 'package:slservers/main.dart';

class ShieldButton extends StatelessWidget {

  Widget icon;
  Color color;
  Widget text;
  double width;
  double height;

  ShieldButton({this.icon, this.color, this.text, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: width,
        height: height,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: width / 7 * 2,
              height: height,
              color: color,
              child: icon,
            ),
            Container(
              color: ColorConstants.background.shade400,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              width: width / 7 * 5,
              height: height,
              child: text,
            )
          ],
        ),
      ),
    );
  }
}
