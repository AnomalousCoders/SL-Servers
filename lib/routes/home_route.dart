import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/server_widget.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

//TODO HOMEPAGE
class _HomeRouteState extends State<HomeRoute> {

  List<Server> servers = List();


  @override
  void initState() {
    Servers.find().then((value) => setState(() {
      print(servers);
      servers = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AuthManager(
        ignoreLogin: true,
        child: ScrollWrapper(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: width, maxWidth: width, minHeight: height),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  color: ColorConstants.primary,
                ),
                Container(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: servers.map((e) => ServerWidget(e)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}