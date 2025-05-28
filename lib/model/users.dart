class User {
  String? id;
  String? name;
  String? gender;
  String? email;

  User({this.id, this.name, this.gender, this.email});
  User.fromefirestor(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    gender = data?["gender"];
    email = data?["email"];
  }
  Map<String, dynamic> tofirestor() {
    return {"id": id, "name": name, "gender": gender, "email": email};
  }
}
