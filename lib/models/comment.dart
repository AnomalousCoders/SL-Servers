class Comment {
    String content;
    String owner;
    String timestamp;

    Comment({this.content, this.owner, this.timestamp});

    factory Comment.fromJson(Map<String, dynamic> json) {
        return Comment(
            content: json['content'], 
            owner: json['owner'], 
            timestamp: json['timestamp'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['owner'] = this.owner;
        data['timestamp'] = this.timestamp;
        return data;
    }
}