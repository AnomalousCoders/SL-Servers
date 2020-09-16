class PendingVerification {
    String address;
    String id;
    String network;
    String verToken;

    PendingVerification({this.address, this.id, this.network, this.verToken});

    factory PendingVerification.fromJson(Map<String, dynamic> json) {
        return PendingVerification(
            address: json['address'],
            id: json['id'], 
            network: json['network'], 
            verToken: json['verToken'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['id'] = this.id;
        data['network'] = this.network;
        data['verToken'] = this.verToken;
        return data;
    }
}