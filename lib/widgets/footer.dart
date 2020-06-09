import 'package:flutter/material.dart';
import 'package:slservers/main.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 6;
    return Container(
      height: height,
      width: double.infinity,
      color: ColorConstants.background.shade600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Impressum: Link fehlend"),
          Text("Lorem ipsum"),
          Text("Dolor si me amet")
        ],
      ),
    );
  }
}
