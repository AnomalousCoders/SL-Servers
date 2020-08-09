import 'dart:html';

import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/appbar.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/server_widget.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key, this.intialPage = 0}) : super(key: key);
  
  int intialPage;

  @override
  _HomeRouteState createState() => _HomeRouteState(this);
}

//TODO HOMEPAGE
class _HomeRouteState extends State<HomeRoute> {
  
  HomeRoute parent;


  _HomeRouteState(this.parent);

  List<Server> servers = List();
  int currentPage = 0;
  int pages = 0;

  @override
  void initState() {
    currentPage = parent.intialPage;
    load();
  }

  void load() {
    Servers.find(page: currentPage).then((value) => setState(() {
      print(servers);
      servers = value.content;
      currentPage = value.current;
      pages = value.pages;
    }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SLSAppBar(),
      body: AuthManager(
        ignoreLogin: true,
        child: (_) => ScrollWrapper(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: width, maxWidth: width, minHeight: height),
            child: Column(
              children: <Widget>[
                /*
                Container(
                  width: double.infinity,
                  height: 100,
                  color: ColorConstants.primary,
                ),
                 */
                Container(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: servers.map((e) => ServerWidget(e)).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.chevron_left), onPressed: () {
                      if (currentPage != 0) {
                        currentPage--;
                        SLServers.router.navigateTo(context, "/list/$currentPage");
                      }
                    }),
                    Text("${currentPage + 1}  |  $pages", style: TextStyle(fontWeight: FontWeight.bold),),
                    IconButton(icon: Icon(Icons.chevron_right), onPressed: () {
                      if (currentPage + 1 < pages) {
                        currentPage++;
                        SLServers.router.navigateTo(context, "/list/$currentPage");
                      }
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}