import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:slservers/models/ip_api_response.dart';

class IpApi {

  //"https://virtserver.swaggerhub.com/Helight/SLServers/1.0.0"
  static const String QUERY = "http://ip-api.com/json/?fields=status,message,country,countryCode";

  static Future<IpApiResponse> get() async {
    var response = await http.get(QUERY);
    return IpApiResponse.fromJson(jsonDecode(response.body));
  }

}