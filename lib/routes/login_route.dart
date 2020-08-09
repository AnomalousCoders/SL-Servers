import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slservers/main.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';

class LoginRoute extends StatefulWidget {
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {

  bool _signIn = false;

  String _email = "";
  String _username = "";
  String _password = "";
  String _passwordConfirm = "";

  GlobalKey scaffold = GlobalKey(debugLabel: "LoginScaffold");

  StreamSubscription<FirebaseUser> streamSub;

  @override
  Widget build(BuildContext context) {
    print("Building Login");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffold,
      body: AuthManager(
        ignoreLogin: true,
        child: (_) =>  ScrollWrapper(
          wrapScreenSize: true,
          child: Center(
            child: SyncSwitchWidget(
              boolean: _signIn,
              positive: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network("https://i.imgur.com/TJobSns.jpg", fit: BoxFit.fitWidth, width: width * 0.1),
                  Container(
                    height: 16,
                  ),
                  Container(
                    width: width * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "username",
                            container: false,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _username), onChanged: (s) => _username = s, decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorConstants.background.shade400,
                              prefixIcon: Icon(Icons.person),
                              labelText: "Username",
                            )),
                          ), width: width * 0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "email",
                            container: false,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _email), onChanged: (s) => _email = s, decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.background.shade400,
                                prefixIcon: Icon(Icons.mail),
                                labelText: "E-Mail"
                            )),
                          ), width: width * 0.2,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "password",
                            container: false,
                            obscured: true,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _password), onChanged: (s) => _password = s, decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.background.shade400,
                                prefixIcon: Icon(Icons.lock),
                                labelText: "Password"
                            ), obscureText: true,),
                          ), width: width * 0.2,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "confirm",
                            container: false,
                            obscured: true,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _passwordConfirm), onChanged: (s) => _passwordConfirm = s, decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.background.shade400,
                                prefixIcon: Icon(Icons.lock),
                                labelText: "Confirm Password"
                            ), obscureText: true,),
                          ), width: width * 0.2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(child: Text("Register"), onPressed: () async {
                                bool complete = _email != null && _username != null && _password != null && _passwordConfirm != null;

                                if (_passwordConfirm != _password) {
                                  _passwordNotMatch(context);
                                  return;
                                }

                                if (complete) {
                                  try {
                                    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                                    _username = null;
                                    _email = null;
                                    _password = null;

                                    if (result.user == null) {
                                      throw Exception("FirebaseUser is null");
                                    }

                                    UserUpdateInfo update = UserUpdateInfo();
                                    update.displayName =_username;
                                    await result.user.updateProfile(update);
                                    _loginSuccessful(context);
                                    print("Token: ${result.user.getIdToken()}");
                                    Navigator.pushReplacementNamed(context, AuthManager.getAfterLoginOnce());
                                    return;
                                  } catch (_) {
                                    _unsuccessfulRegistration(context);
                                  }
                                } else {
                                  _unsuccessfulRegistration(context);
                                }
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(child: Text("Login instead"), onPressed: ()  {
                                setState(() {
                                  _signIn = false;
                                });
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              negative: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network("https://i.imgur.com/TJobSns.jpg", fit: BoxFit.fitWidth, width: width * 0.1),
                  Container(
                    height: 16,
                  ),
                  Container(
                    width: width * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "email",
                            container: false,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _email), onChanged: (s) => _email = s, decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.background.shade400,
                                prefixIcon: Icon(Icons.mail),
                                labelText: "E-Mail"
                            ), keyboardType: TextInputType.emailAddress,),
                          ), width: width * 0.2,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Semantics(
                            label: "password",
                            container: false,
                            textField: true,
                            child: TextField(controller: TextEditingController(text: _password), onChanged: (s) => _password = s, decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.background.shade400,
                                prefixIcon: Icon(Icons.lock),
                                labelText: "Password"
                            ), obscureText: true,),
                          ), width: width * 0.2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(child: Text("Sign in"), onPressed: () async {
                                bool complete = _email != null && _password != null;

                                if (complete) {
                                  AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                                  _username = null;
                                  _email = null;
                                  _password = null;
                                  _passwordConfirm = null;

                                  if (result.user == null) {
                                    throw Exception("FirebaseUser is null");
                                  }

                                  _loginSuccessful(context);
                                  print("Token: ${(await result.user.getIdToken()).token}");
                                  Navigator.pushReplacementNamed(context, AuthManager.getAfterLoginOnce());
                                  return;
                                } else {
                                  _unsuccessfulLogin(context);
                                }
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(child: Text("Register instead"), onPressed: ()  {
                                setState(() {
                                  _signIn = true;
                                });
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    streamSub = FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      if (event.isAnonymous) return;
      Navigator.pushReplacementNamed(context, AuthManager.afterLogin??"/");
    });
  }


  @override
  void dispose() {
    streamSub.cancel();
    super.dispose();
  }

  void _loginSuccessful(BuildContext context) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Login successful", style: TextStyle(color: Colors.white, fontSize: 18),),
    ), backgroundColor: Colors.green.shade800,);
    (scaffold.currentState as ScaffoldState).showSnackBar(snack);
  }

  void _passwordNotMatch(BuildContext context) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("The two passwords don't match", style: TextStyle(color: Colors.white, fontSize: 18),),
    ), backgroundColor: Colors.red.shade800,);
    (scaffold.currentState as ScaffoldState).showSnackBar(snack);
  }

  void _unsuccessfulRegistration(BuildContext context) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Registration unsuccessful. Please check your input", style: TextStyle(color: Colors.white, fontSize: 18),),
    ), backgroundColor: Colors.red.shade800,);
    (scaffold.currentState as ScaffoldState).showSnackBar(snack);
  }

  void _unsuccessfulLogin(BuildContext context) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Login failed. Please check your input", style: TextStyle(color: Colors.white, fontSize: 18),),
    ), backgroundColor: Colors.red.shade800,);
    (scaffold.currentState as ScaffoldState).showSnackBar(snack);
  }

}