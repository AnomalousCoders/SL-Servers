import 'package:flutter/material.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/my_servers_body.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';

class ManageServerRoute extends StatefulWidget {
  ManageServerRoute({Key key}) : super(key: key);

  @override
  _ManageServerRouteState createState() => _ManageServerRouteState();
}

class _ManageServerRouteState extends State<ManageServerRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthManager(
        ignoreLogin: false,
        child: (context) => ScrollWrapper(
          child: Column(
            children: [
              MyServersBody()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

}