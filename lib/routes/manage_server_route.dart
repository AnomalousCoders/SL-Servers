import 'package:flutter/material.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/my_servers_body.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';

class ManageServerRoute extends StatefulWidget {

  ManageServerRoute({Key key}) : super(key: key);

  @override
  _ManageServerRouteState createState() => _ManageServerRouteState();


  static void showSnack(BuildContext context, Color color, String message) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(message, style: TextStyle(color: Colors.white, fontSize: 18),),
    ), backgroundColor: color,);
    (_ManageServerRouteState.scaffoldKey.currentState as ScaffoldState).showSnackBar(snack);
  }

}

class _ManageServerRouteState extends State<ManageServerRoute> {


  static GlobalKey scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: AuthManager(
        ignoreLogin: false,
        child: (context) => ScrollWrapper(
          wrapScreenSize: true,
          child:  MyServersBody(),
        ),
      ),
    );
  }

  @override
  void initState() {
    scaffoldKey = new GlobalKey();
    super.initState();
  }

}