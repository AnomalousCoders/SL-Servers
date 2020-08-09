import 'package:flutter/material.dart';

class ReroutingWidget extends StatelessWidget {


  final Widget Function(BuildContext) child;
  final Widget Function(BuildContext) awaiting;
  final String route;
  final Future<bool> future;


  ReroutingWidget({this.child, this.route, this.future, this.awaiting}) : super();

  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snapshot) {

      if (snapshot.connectionState == ConnectionState.done) {
        if (!snapshot.data) {
          return child(context);
        } else {
          print("Rerouting to $route");
          Future.delayed(Duration.zero, () =>  Navigator.pushReplacementNamed(context, route));
          return Container();
        }
      }

      return awaiting(context);
    }, future: future,);
  }
}
