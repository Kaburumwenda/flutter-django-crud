class Note {
  int  id;
  String  body;

  Note({ this.id, this.body});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    return data;
  }
}
