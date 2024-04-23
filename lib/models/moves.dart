class Move {
  int? accuracy;
  String? category;
  String? cname;
  String? ename;
  int? id;
  String? jname;
  int? power;
  int? pp;
  String? type;

  Move(
      {this.accuracy,
      this.category,
      this.cname,
      this.ename,
      this.id,
      this.jname,
      this.power,
      this.pp,
      this.type});

  Move.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    category = json['category'];
    cname = json['cname'];
    ename = json['ename'];
    id = json['id'];
    jname = json['jname'];
    power = json['power'];
    pp = json['pp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['category'] = this.category;
    data['cname'] = this.cname;
    data['ename'] = this.ename;
    data['id'] = this.id;
    data['jname'] = this.jname;
    data['power'] = this.power;
    data['pp'] = this.pp;
    data['type'] = this.type;
    return data;
  }
}
