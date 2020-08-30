import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:slservers/models/ip_api_response.dart';

class IpApi {

  //"https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0"
  static const String QUERY = "https://ipapi.co/json";

  static Future<ApiResponse> get() async {
    var response = await http.get(QUERY);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }

}