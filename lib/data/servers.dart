import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:slservers/models/server.dart';
import 'package:slservers/models/server_instance.dart';
import 'package:slservers/models/server_response.dart';

class Servers {

  //"https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0"
  static const String API_LOCATION = "http://localhost:8080";

  static Future<PaginatedServerResponse> find({int page = 0}) async {
    var response = await http.get("$API_LOCATION/server?page=$page&limit=10");
    return PaginatedServerResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static Future<bool> create(Server server) async {
    var user = await FirebaseAuth.instance.currentUser();
    var token = (await user.getIdToken()).token;
    print(token);
    var response = await http.post("$API_LOCATION/server", headers: {"Authorization": "Bearer $token"}, body: jsonEncode(server.toJson()));
    print(response);
    return true;
  }

  static Future<Server> _get(String id) async {
    String url = "$API_LOCATION/server/$id";
    print(url);
    var response = await http.get(url);
    print(response.toString());
    return Server.fromJson(jsonDecode(response.body));
  }

  static Future<List<ServerInstance>> _instances(String id) async {
    var response = await http.get("$API_LOCATION/server/$id/instance");
    print("Instances: ${response.body}");
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => ServerInstance.fromJson(e)).toList();
  }

  static Future<Server> preloadId(String id, BuildContext context) async {
    print("Getting server");
    Server server = await _get(id);
    print("Response: ${server.toJson()}");
    server.instanceRefs = await _instances(id);
    await precacheImage(NetworkImage(server.banner), context);
    await precacheImage(NetworkImage(server.icon), context);
    return server;
  }

  static Future<bool> vote(String id) async {
    var response = await http.post("$API_LOCATION/server/$id/vote");
    return response.statusCode == 204;
  }


}