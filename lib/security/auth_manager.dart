import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slservers/widgets/rerouting_widget.dart';

class AuthManager extends StatefulWidget {

  static String afterLogin = "/";

  static User user;

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
  _AuthManagerState createState() => _AuthManagerState();

  static AuthManager ofContext({@required BuildContext context}) {
    return context.findAncestorWidgetOfExactType<AuthManager>();
  }

}

class _AuthManagerState extends State<AuthManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReroutingWidget(child: widget.child, route: "/login", future: shouldReroute(), awaiting: (_) => Scaffold(),),
    );
  }


  void requireLogin({@required BuildContext context}) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<bool> checkAuthorized() async {
    AuthManager.user = FirebaseAuth.instance.currentUser;
    if (AuthManager.user==null) return false;
    return true;
  }

  Future<bool> shouldReroute() async {
    bool authenticated = await checkAuthorized();
    bool reroute = widget.ignoreLogin ? false : !authenticated;
    print("Rerouting: $reroute Authenticated: $authenticated");
    if (reroute && !widget.ignoreLogin) AuthManager.afterLogin = widget.al;
    return reroute;
  }
}
