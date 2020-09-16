import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/routes/create_route.dart';
import 'package:slservers/routes/home_route.dart';
import 'package:slservers/routes/instance_route.dart';
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
      return HomeRoute(intialPage: page, localized: false,);
  });

}


class LocalizedListHandler extends Handler {

  LocalizedListHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
    int page = int.parse(params["page"][0]);
    print("Loaded page $page");
    return HomeRoute(intialPage: page, localized: true,);
  });

}

class EditHandler extends Handler {

  EditHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
    String page = params["network"][0];
    return FutureBuilder(
      builder: (ctx,dat) {
        if (dat.connectionState == ConnectionState.done) {
          var server = (dat.data as List<Server>).firstWhere((element) => element.id == page);
          return CreateRoute(initial: server,);
        }
        return Container();
      },
      future: Servers.myServers(),
    );
  });

}


class InstancesHandler extends Handler {

  InstancesHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
    String server = params["server"][0];
    return FutureBuilder(
      builder: (ctx,dat) {
        return InstanceRoute(id: server,);
      },
      future: Servers.myServers(),
    );
  });

}