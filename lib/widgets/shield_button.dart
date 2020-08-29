import 'package:flutter/material.dart';

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
      borderRadius: BorderRadius.circular(8),
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
              child: icon,
              decoration: BoxDecoration(
                color: color,
                boxShadow: [BoxShadow(color: color, blurRadius: 50, offset: Offset(10,0))]
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16),
                height: height,
                child: text,
              ),
            )
          ],
        ),
      ),
    );
  }
}
