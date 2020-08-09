import 'package:slservers/models/server.dart';

class PaginatedServerResponse {
    List<Server> content;
    int current;
    int pages;

    PaginatedServerResponse({this.content, this.current, this.pages});

    factory PaginatedServerResponse.fromJson(Map<String, dynamic> json) {
        return PaginatedServerResponse(
            content: json['content'] != null ? (json['content'] as List).map((i) => Server.fromJson(i)).toList() : null,
            current: json['current'], 
            pages: json['pages'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['current'] = this.current;
        data['pages'] = this.pages;
        if (this.content != null) {
            data['content'] = this.content.map((v) => v.toJson()).toList();
        }
        return data;
    }
}