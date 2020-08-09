import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slservers/widgets/rerouting_widget.dart';

class AuthManager extends StatelessWidget {

  static String afterLogin = "/";

  static FirebaseUser user;

  final Widget Function(BuildContext) child;

  static String getAfterLoginOnce() {
    String snap = afterLogin;
    afterLogin = null;
    return snap;
  }

  bool ignoreLogin = false;

  String al = "/";

  AuthManager({Key key, this.child, this.ignoreLogin, this.al}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReroutingWidget(child: child, route: "/login", future: shouldReroute(), awaiting: (_) => Scaffold(),),
    );
  }

  void requireLogin({@required BuildContext context}) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<bool> checkAuthorized() async {
    user = await FirebaseAuth.instance.currentUser();
    if (user==null) return false;
    return true;
  }

  Future<bool> shouldReroute() async {
    bool authenticated = await checkAuthorized();
    bool reroute = ignoreLogin ? false : !authenticated;
    print("Rerouting: $reroute Authenticated: $authenticated");
    if (reroute && !ignoreLogin) afterLogin = al;
    return reroute;
  }

  static AuthManager ofContext({@required BuildContext context}) {
    return context.findAncestorWidgetOfExactType<AuthManager>();
  }

}
