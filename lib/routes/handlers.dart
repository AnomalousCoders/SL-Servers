import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/routes/server_route.dart';

class ServerHandler extends Handler {

  ServerHandler() : super(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
    String id = params["server"][0];
    return FutureBuilder(future: Servers.preloadId(id, context), builder: (context, snapshot) {

      if (snapshot.connectionState != ConnectionState.done) {
        return Scaffold(body: Center(child: CircularProgressIndicator(),));
      }

      return ServerRoute(server: snapshot.data);
    });
  });

}