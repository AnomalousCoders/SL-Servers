class ServerInstance {
    String address;
    String description;
    String id;
    int maxplayers;
    String name;
    int players;
    List<String> plugins;
    List<String> tags;
    bool verified;
    bool ff;
    String version;

    ServerInstance({this.address, this.description, this.id, this.maxplayers, this.name, this.players, this.plugins, this.tags, this.verified, this.ff, this.version,});

    factory ServerInstance.fromJson(Map<String, dynamic> json) {
        return ServerInstance(
            address: json['address'], 
            description: json['description'], 
            id: json['id'], 
            maxplayers: json['maxplayers'], 
            name: json['name'], 
            players: json['players'], 
            plugins: json['plugins'] != null ? new List<String>.from(json['plugins']) : null, 
            tags: json['tags'] != null ? new List<String>.from(json['tags']) : null, 
            verified: json['verified'] != null ? json['verified'] : false,
            ff: json['ff'] != null ? json['verified'] : false,
            version: json['version'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['description'] = this.description;
        data['id'] = this.id;
        data['maxplayers'] = this.maxplayers;
        data['name'] = this.name;
        data['players'] = this.players;
        data['verified'] = this.verified;
        data['ff'] = this.ff;
        data['version'] = this.version;
        if (this.plugins != null) {
            data['plugins'] = this.plugins;
        }
        if (this.tags != null) {
            data['tags'] = this.tags;
        }
        return data;
    }
}