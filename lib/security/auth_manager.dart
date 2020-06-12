import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slservers/widgets/rerouting_widget.dart';

class AuthManager extends StatelessWidget {

  static FirebaseUser user;

  final Widget child;

  bool ignoreLogin = false;

  AuthManager({Key key, this.child, this.ignoreLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReroutingWidget(child: (_) => child, route: "/login", future: shouldReroute(), awaiting: (_) => Scaffold(),),
    );
  }

  void requireLogin({@required BuildContext context}) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<bool> checkAuthorized() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<bool> shouldReroute() async {
    bool authenticated = await checkAuthorized();
    return ignoreLogin ? false : authenticated;
  }

  static AuthManager ofContext({@required BuildContext context}) {
    return context.findAncestorWidgetOfExactType<AuthManager>();
  }

}
