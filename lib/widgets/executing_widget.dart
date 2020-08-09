import 'package:flutter/material.dart';

class ExecutingWidget extends StatefulWidget {
  ExecutingWidget(this.function, {Key key}) : super(key: key);

  Function(BuildContext) function;

  @override
  _ExecutingWidgetState createState() => _ExecutingWidgetState(this);
}

class _ExecutingWidgetState extends State<ExecutingWidget> {

  ExecutingWidget parent;

  _ExecutingWidgetState(this.parent);

  @override
  Widget build(BuildContext context) {
    parent.function(context);
    return Container();
  }
}