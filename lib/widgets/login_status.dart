import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slservers/security/auth_manager.dart';

class LoginStatus extends StatefulWidget {
  LoginStatus({Key key}) : super(key: key);

  @override
  _LoginStatusState createState() => _LoginStatusState();
}

class _LoginStatusState extends State<LoginStatus> {

  FirebaseUser user;
  StreamSubscription<FirebaseUser> subscription;

  @override
  void initState() {
    subscription = FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      load();
    });
    super.initState();
    load();
  }

  void load() async {
    user = await FirebaseAuth.instance.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return IconButton(icon: Icon(Icons.vpn_key, size: 30,), onPressed: () {
        AuthManager.afterLogin = "/";
        Navigator.of(context).pushReplacementNamed("/login");
      });
    } else {
     return Row(
       children: [
         IconButton(icon: Icon(Icons.create, size: 30), onPressed: () {
           Navigator.of(context).pushNamed("/create");
         }),
         IconButton(icon: Icon(Icons.person, size: 30,), onPressed: () {

         }),
       ],
     );
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}