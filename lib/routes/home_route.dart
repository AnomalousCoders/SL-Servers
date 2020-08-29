import 'dart:html';

import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/better_checkbox.dart';
import 'package:slservers/widgets/login_status.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/server_widget.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key, this.intialPage = 0, this.localized = true}) : super(key: key);
  
  int intialPage;
  bool localized;

  @override
  _HomeRouteState createState() => _HomeRouteState(this);
}

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
    Servers.find(page: currentPage, localized: parent.localized).then((value) => setState(() {
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
      //appBar: SLSAppBar(),
      body: AuthManager(
        ignoreLogin: true,
        child: (_) => ScrollWrapper(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: width, maxWidth: width, minHeight: height),
            child: Column(
              children: <Widget>[

                Container(
                  width: double.infinity,
                  height: 50,
                  color: ColorConstants.primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LoginStatus()
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 50,
                ),
                Container(
                  width: 1200,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      BetterCheckbox(value: parent.localized, label: "Localized", onChange: (boolean) {
                        parent.localized = boolean;
                        route(context);
                      })
                    ],
                  ),
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
                        route(context);
                      }
                    }),
                    Text("${currentPage + 1}  |  $pages", style: TextStyle(fontWeight: FontWeight.bold),),
                    IconButton(icon: Icon(Icons.chevron_right), onPressed: () {
                      if (currentPage + 1 < pages) {
                        currentPage++;
                        route(context);
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

  void route(BuildContext context) {
    SLServers.router.navigateTo(context, "/list/$currentPage" + (parent.localized?"/local":""));
  }

}