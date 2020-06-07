import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {


  final Widget Function(BuildContext) positive;
  final Widget Function(BuildContext) negative;
  final Widget Function(BuildContext) awaiting;
  final Future<bool> future;

  const SwitchWidget({Key key, this.positive, this.negative, this.awaiting, this.future}) : super(key: key);


  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snapshot) {

      if (snapshot.connectionState == ConnectionState.done) {
        return snapshot.data? positive(context) : negative(context);
      }

      return awaiting(context);
    }, future: future,);
  }
}
