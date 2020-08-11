/// address : "104.243.38.172:7790"
/// hashedAddress : "e9c00238f88bb369e843458fde3c704e"
/// players : 109
/// maxPlayers : 250
/// info : "(US East) King's D-Class's Lobby "
/// name : "King's D-Class's Lobby"
/// pastebin : "https://pastebin.com/raw/SaUCg6Cu/"
/// version : "10.0.1"
/// friendlyFire : false
/// modded : true
/// modFlags : 0
/// whitelist : false
/// official : ""
/// officialCode : 0
/// localization : ["DE"]
/// tags : {"000000":"Exiled 2.0.10","000001":"Test"}

class GameInstance {
  String _address;
  String _hashedAddress;
  int _players;
  int _maxPlayers;
  String _info;
  String _name;
  String _pastebin;
  String _version;
  bool _friendlyFire;
  bool _modded;
  int _modFlags;
  bool _whitelist;
  String _official;
  int _officialCode;
  List<String> _localization;
  Map _tags;

  String get address => _address;
  String get hashedAddress => _hashedAddress;
  int get players => _players;
  int get maxPlayers => _maxPlayers;
  String get info => _info;
  String get name => _name;
  String get pastebin => _pastebin;
  String get version => _version;
  bool get friendlyFire => _friendlyFire;
  bool get modded => _modded;
  int get modFlags => _modFlags;
  bool get whitelist => _whitelist;
  String get official => _official;
  int get officialCode => _officialCode;
  List<String> get localization => _localization;
  Map get tags => _tags;

  GameInstance({
      String address, 
      String hashedAddress, 
      int players, 
      int maxPlayers, 
      String info, 
      String name, 
      String pastebin, 
      String version, 
      bool friendlyFire, 
      bool modded, 
      int modFlags, 
      bool whitelist, 
      String official, 
      int officialCode, 
      List<String> localization, 
      Map tags}){
    _address = address;
    _hashedAddress = hashedAddress;
    _players = players;
    _maxPlayers = maxPlayers;
    _info = info;
    _name = name;
    _pastebin = pastebin;
    _version = version;
    _friendlyFire = friendlyFire;
    _modded = modded;
    _modFlags = modFlags;
    _whitelist = whitelist;
    _official = official;
    _officialCode = officialCode;
    _localization = localization;
    _tags = tags;
}

  GameInstance.fromJson(dynamic json) {
    _address = json["address"];
    _hashedAddress = json["hashedAddress"];
    _players = json["players"];
    _maxPlayers = json["maxPlayers"];
    _info = json["info"];
    _name = json["name"];
    _pastebin = json["pastebin"];
    _version = json["version"];
    _friendlyFire = json["friendlyFire"];
    _modded = json["modded"];
    _modFlags = json["modFlags"];
    _whitelist = json["whitelist"];
    _official = json["official"];
    _officialCode = json["officialCode"];
    _localization = json["localization"] != null ? json["localization"].cast<String>() : [];
    _tags = json["tags"] != null ? json["tags"] : {};
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = _address;
    map["hashedAddress"] = _hashedAddress;
    map["players"] = _players;
    map["maxPlayers"] = _maxPlayers;
    map["info"] = _info;
    map["name"] = _name;
    map["pastebin"] = _pastebin;
    map["version"] = _version;
    map["friendlyFire"] = _friendlyFire;
    map["modded"] = _modded;
    map["modFlags"] = _modFlags;
    map["whitelist"] = _whitelist;
    map["official"] = _official;
    map["officialCode"] = _officialCode;
    map["localization"] = _localization;
    if (_tags != null) {
      map["tags"] = _tags;
    }
    return map;
  }

}