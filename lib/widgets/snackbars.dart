import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void snack(BuildContext context, Color color, String message) {
  final SnackBar snack = SnackBar(content: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(message, style: TextStyle(color: Colors.white, fontSize: 18),),
  ), backgroundColor: color,);

  ScaffoldState state = context.findAncestorStateOfType<ScaffoldState>();
  state.showSnackBar(snack);
}

void success(BuildContext context, String message) {
  snack(context, Colors.lightGreenAccent, message);
}

void info(BuildContext context, String message) {
  snack(context, Colors.lightBlueAccent, message);
}

void error(BuildContext context, String message) {
  snack(context, Colors.redAccent, message);
}

void warning(BuildContext context, String message) {
  snack(context, Colors.yellow, message);
}

