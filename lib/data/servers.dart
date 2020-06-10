import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:slservers/models/server.dart';

class Servers {

  static const String API_LOCATION = "https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0";

  static Future<List<Server>> find() async {
    var response = await http.get("$API_LOCATION/server");
    print(response.body);
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => Server.fromJson(e)).toList();
  }

}