class IpApiResponse {
  String _status;
  String _country;
  String _countryCode;

  String get status => _status;
  String get country => _country;
  String get countryCode => _countryCode;

  IpApiResponse({
      String status, 
      String country, 
      String countryCode}){
    _status = status;
    _country = country;
    _countryCode = countryCode;
}

  IpApiResponse.fromJson(dynamic json) {
    _status = json["status"];
    _country = json["country"];
    _countryCode = json["countryCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["country"] = _country;
    map["countryCode"] = _countryCode;
    return map;
  }

}