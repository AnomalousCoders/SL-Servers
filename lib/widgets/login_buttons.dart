
import 'dart:ui';

import 'package:flutter/material.dart';

Widget google(BuildContext context, VoidCallback callback) => new ButtonDescription(
  color: Colors.white,
  logo: "go-logo.png",
  label: "Sign in with Google",
  name: "Google",
  labelColor: Colors.grey,
  onSelected: callback,
);

class ButtonDescription extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color color;
  final String logo;
  final String name;
  final VoidCallback onSelected;

  const ButtonDescription({@required this.logo,
    @required this.label,
    @required this.name,
    this.onSelected,
    this.labelColor = Colors.grey,
    this.color = Colors.white});

  ButtonDescription copyWith({
    String label,
    Color labelColor,
    Color color,
    String logo,
    String name,
    VoidCallback onSelected,
  }) {
    return new ButtonDescription(
        label: label ?? this.label,
        labelColor: labelColor ?? this.labelColor,
        color: color ?? this.color,
        logo: logo ?? this.logo,
        name: name ?? this.name,
        onSelected: onSelected ?? this.onSelected);
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback _onSelected = onSelected ?? () => {};
    return Container(
      height: 50,
      child: new RaisedButton(
          color: color,
          child: new Row(
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                  child: Image.network('images/$logo')),
              new Expanded(
                child: new Text(
                  label,
                  style: new TextStyle(color: labelColor),
                ),
              )
            ],
          ),
          onPressed: _onSelected),
    );
  }
}