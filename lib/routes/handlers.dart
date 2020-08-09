import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/routes/home_route.dart';
import 'package:slservers/routes/server_route.dart';

class ServerHandler extends Handler {

  ServerHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
    String id = params["server"][0];
    print("Id: $id");
    return FutureBuilder(future: Servers.preloadId(id, context), builder: (context, snapshot) {

      if (snapshot.connectionState != ConnectionState.done) {
        return Scaffold(body: Center(child: CircularProgressIndicator(),));
      }

      return ServerRoute(server: snapshot.data);
    });
  });

}

class ListHandler extends Handler {

  ListHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
      int page = int.parse(params["page"][0]);
      print("Loaded page $page");
      return HomeRoute(intialPage: page,);
  });

}