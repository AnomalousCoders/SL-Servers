import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:expire_cache/expire_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:slservers/data/ipapi.dart';
import 'package:slservers/models/game_instance.dart';
import 'package:slservers/models/ip_api_response.dart';
import 'package:slservers/models/pending_verification.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/models/server_instance.dart';
import 'package:slservers/models/server_response.dart';

class Servers {

  static ExpireCache<String,Server> serverCache = ExpireCache<String,Server>(expireDuration: Duration(seconds: 15), sizeLimit: 5, gcDuration: Duration(seconds: 10));
  static ExpireCache<String,PaginatedServerResponse> pageCache = ExpireCache<String,PaginatedServerResponse>(expireDuration: Duration(seconds: 15), sizeLimit: 10, gcDuration: Duration(seconds: 10));

  //"https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0"
  static const String API_LOCATION = "https://api.slservers.eu";
  static const String DEBUG_LOCATION = "http://localhost";

  static String get location => kReleaseMode ? API_LOCATION : DEBUG_LOCATION;

  static Future<PaginatedServerResponse> find({int page = 0, bool localized = true}) async {
    var response;
    String ckey = "$localized.$page";
    if (pageCache.containsKey(ckey) && !pageCache.isCacheEntryExpired(ckey)) {
      return await pageCache.get(ckey);
    }

    if (localized) {
      ApiResponse ip = await IpApi.get();
      response = await http.get("$location/server?page=$page&limit=10&languages=${ip.country}");
    } else {
      response = await http.get("$location/server?page=$page&limit=10");
    }

    var pr = PaginatedServerResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    pageCache.set(ckey, pr);
    return pr;
  }


  static Future<bool> create(Server server) async {
    serverCache.invalidate(server.id);

    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.post("$location/server", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}, body: jsonEncode(server.toJson()));
    return true;
  }

  static Future<bool> update(Server server) async {
    serverCache.invalidate(server.id);

    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.put("$location/server", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}, body: jsonEncode(server.toJson()));
    return true;
  }

  static Future<List<PendingVerification>> getAllPending(Server server) async {
    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.get("$location/server/${server.id}/pending", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"});
    List objects = jsonDecode(response.body);
    return objects.map((e) => PendingVerification.fromJson(e)).toList();
  }

  static Future<bool> updateInstance(Server server, ServerInstance instance) async {
    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.put("$location/server/${server.id}/instance/${instance.id}", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}, body: jsonEncode(instance.toJson()));
    return true;
  }


  static Future<bool> deleteInstance(Server server, ServerInstance instance) async {
    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.delete("$location/server/${server.id}/instance/${instance.id}", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"});
    return true;
  }


  static Future<bool> delete(Server server) async {
    serverCache.invalidate(server.id);

    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.delete("$location/server?server=${server.id}", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"});
    return true;
  }

  static Future<String> registerServer(Server server, String address) async {
    var user = FirebaseAuth.instance.currentUser;
    var token = (await user.getIdToken());
    var response = await http.post("$location/server/${server.id}/registerInstance", headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}, body: address);
    Map<String,dynamic> json = jsonDecode(response.body);
    return json["verToken"];
  }

  static Future<Server> get(String id) async {

    if (serverCache.containsKey(id) && !serverCache.isCacheEntryExpired(id)) {
      return await serverCache.get(id);
    }

    String url = "$location/server/$id";
    var response = await http.get(url);
    var server = Server.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    serverCache.set(server.id,server);
    return server;
  }

  static Future<List<ServerInstance>> _instances(String id) async {
    var response = await http.get("$location/server/$id/instance");
    List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
    return list.map((e) => ServerInstance.fromJson(e)).toList();
  }

  static Future<Server> preloadId(String id, BuildContext context, {bool adminLoad = false}) async {
    Server server = await get(id);

    if (adminLoad) {
      List<PendingVerification> verifications = await getAllPending(server);
      server.pendingRefs = verifications;
    }


    if (server.autogenerated) {
      ServerInstance instance = new ServerInstance(id: server.id, address: "${server.vaddress}:${server.vport}", verified: true, name: server.name, description: "");
      server.instanceRefs = [instance];
      if (server.description != null && server.description != "") {
        try {
          server.description = "";
        } catch (e) {
          throw e;
        }
      }
    } else {
      server.instanceRefs = await _instances(id);
    }

    for (ServerInstance element in server.instanceRefs) {
      String hashedAddress = _digestMD5(element.address);
      GameInstance i = await gameInstance(hashedAddress);
      if (i != null) {
        element.players = i.players;
        element.maxplayers = i.maxPlayers;
        element.version = i.version;
        element.ff = i.friendlyFire;
      } else {
        element.players = 0;
        element.maxplayers = 0;
        element.version = "none";
        element.ff = false;
      }
    }

    /*
    if (server.banner != null && server.banner != "") await precacheImage(NetworkImage(server.banner), context);
    if (server.icon != null && server.icon != "") await precacheImage(NetworkImage(server.icon), context);
    */

    return server;
  }

  static Future<List<Server>> myServers() async {
    String token = (await (FirebaseAuth.instance.currentUser).getIdToken());
    var response = await http.get("$location/myServers",  headers: {"Authorization": "Bearer $token"});
    print(response.body);
    List<dynamic> servers = jsonDecode(response.body);
    List<Server> list = servers.map((e) => Server.fromJson(e)).toList();
    print(list.toList());
    return list;
  }
  
  static Future<GameInstance> gameInstance(String hashedAddress) async {
    try {
      var response = await http.get("$location/game/$hashedAddress");
      Map<String,dynamic> decoded = jsonDecode(response.body);
      GameInstance instance = GameInstance.fromJson(decoded);
      return instance;
    } catch (_) {
      return null;
    }
  } 

  static Future<bool> vote(String id) async {
    var response = await http.post("$location/server/$id/vote");
    return response.statusCode == 204;
  }

  static String _digestMD5(String address) {
    var content = new Utf8Encoder().convert(address);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

}