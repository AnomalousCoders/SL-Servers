import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:slservers/models/instance.dart';
import 'package:slservers/models/server.dart';

class Servers {

  static const String API_LOCATION = "https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0";

  static Future<List<Server>> find() async {
    var response = await http.get("$API_LOCATION/server");
    print(response.body);
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => Server.fromJson(e)).toList();
  }

  static Future<Server> _get(String id) async {
    var response = await http.get("$API_LOCATION/server/$id/");
    print(response.body);
    return Server.fromJson(jsonDecode(response.body));
  }

  static Future<List<ServerInstance>> _instances(String id) async {
    var response = await http.get("$API_LOCATION/server/$id/instance");
    print("Instances: ${response.body}");
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => ServerInstance.fromJson(e)).toList();
  }

  static Future<Server> preloadId(String id, BuildContext context) async {
    Server server = await _get(id);
    server.instanceRefs = await _instances(id);
    await precacheImage(NetworkImage(server.banner), context);
    await precacheImage(NetworkImage(server.icon), context);
    return server;
  }


}