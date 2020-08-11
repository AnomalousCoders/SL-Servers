/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// address : "127.0.0.1:7777"
/// name : "Cookies4Life"
/// description : "Our biggest server"
/// verified : true
/// version : "scopophobia-beta"
/// players : 15
/// maxplayers : 20
/// ff : true
/// tags : ["ffon"]
/// plugins : ["Scp035","StalkingLarry"]

class ServerInstance {
  String _id;
  String _address;
  String _name;
  String _description;
  bool _verified;
  String _version;
  int _players;
  int _maxplayers;
  bool _ff;
  List<String> _tags;
  List<String> _plugins;

  String get id => _id;
  String get address => _address;
  String get name => _name;
  String get description => _description;
  bool get verified => _verified;
  String get version => _version;
  int get players => _players;
  int get maxplayers => _maxplayers;
  bool get ff => _ff;
  List<String> get tags => _tags;
  List<String> get plugins => _plugins;


  set version(String value) {
    _version = value;
  }

  ServerInstance({
      String id, 
      String address, 
      String name, 
      String description, 
      bool verified, 
      String version, 
      int players, 
      int maxplayers, 
      bool ff, 
      List<String> tags, 
      List<String> plugins}){
    _id = id;
    _address = address;
    _name = name;
    _description = description;
    _verified = verified;
    _version = version;
    _players = players;
    _maxplayers = maxplayers;
    _ff = ff;
    _tags = tags;
    _plugins = plugins;
}

  ServerInstance.fromJson(dynamic json) {
    _id = json["id"];
    _address = json["address"];
    _name = json["name"];
    _description = json["description"];
    _verified = json["verified"];
    _version = json["version"];
    _players = json["players"];
    _maxplayers = json["maxplayers"];
    _ff = json["ff"];
    _tags = json["tags"] != null ? json["tags"].cast<String>() : [];
    _plugins = json["plugins"] != null ? json["plugins"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["address"] = _address;
    map["name"] = _name;
    map["description"] = _description;
    map["verified"] = _verified;
    map["version"] = _version;
    map["players"] = _players;
    map["maxplayers"] = _maxplayers;
    map["ff"] = _ff;
    map["tags"] = _tags;
    map["plugins"] = _plugins;
    return map;
  }

  set players(int value) {
    _players = value;
  }

  set maxplayers(int value) {
    _maxplayers = value;
  }

  set ff(bool value) {
    _ff = value;
  }
}